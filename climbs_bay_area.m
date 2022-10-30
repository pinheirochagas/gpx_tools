Example 5
---------
% Display elevation and time area maps.
% Calculate distance using track logs.
% Read the track log from the sample_mixed.gpx file.



e = wgs84Ellipsoid;

itabirito =  gpxread('/Users/pinheirochagas/Downloads/Serra Itabirito.gpx','FeatureType','track');
mdiablo =  gpxread('/Users/pinheirochagas/Downloads/Mt. Diablo.gpx','FeatureType','track');
mtam = gpxread('/Users/pinheirochagas/Downloads/Mill Valley to M. Tam East Peak.gpx','FeatureType','track');
twinpeaks17 = gpxread('/Users/pinheirochagas/Downloads/17th St. to Twin Peaks.gpx','FeatureType','track'); 
spruce = gpxread('/Users/pinheirochagas/Downloads/Spruce St. Berkeley.gpx','FeatureType','track'); 
twinpeaksPort = gpxread('/Users/pinheirochagas/Downloads/Twin Peaks via Portola.gpx','FeatureType','track'); 
hawk = gpxread('/Users/pinheirochagas/Downloads/Hawk Hill.gpx','FeatureType','track'); 
mhamil = gpxread('/Users/pinheirochagas/Downloads/Mt. Hamilton.gpx','FeatureType','track'); 
oldlahonda = gpxread('/Users/pinheirochagas/Downloads/Old La Honda.gpx','FeatureType','track'); 
kings = gpxread('/Users/pinheirochagas/Downloads/Kings Mountain via Huddart.gpx','FeatureType','track'); 
tunitas = gpxread('/Users/pinheirochagas/Downloads/Tunitas Creek.gpx','FeatureType','track'); 
bofax = gpxread('/Users/pinheirochagas/Downloads/BoFax Climb.gpx','FeatureType','track'); 



loadgpx('/Users/pinheirochagas/Downloads/BoFax Climb.gpx')

t = struct

% t.itabirito = itabirito;
t.mdiablo = mdiablo;
t.mtam = mtam;
t.twin17 = twinpeaks17;
t.twinPort = twinpeaksPort;
t.hawk = hawk;
% t.mhamil = mhamil;
t.oldlahonda = oldlahonda;
t.kings = kings
t.tunitas = tunitas
t.bofax = bofax

% t.spruce = spruce;

climbs = fieldnames(t)

for i = 1:length(climbs)

lat = t.(climbs{i}).Latitude;
lon = t.(climbs{i}).Longitude;
Distance = distance(lat(1:end-1),lon(1:end-1),lat(2:end),lon(2:end),e);
Distance = Distance * unitsratio('sm','meter');
t.(climbs{i}).Distance = Distance;
t.(climbs{i}).CumDistance = cumsum(Distance);

% t.(climbs{i}).Distance = Distance * 1.6;
t.(climbs{i}).Elevation = distdim(t.(climbs{i}).Elevation, 'meters', 'feet');
t.(climbs{i}).CumDistance = distdim(t.(climbs{i}).CumDistance , 'meter', 'feet');

slope1 = polyfit(t.(climbs{i}).CumDistance,t.(climbs{i}).Elevation,1)
slopes(i) = slope1(1)
end
% 
% for i = 1:length(climbs)
% slope1 = polyfit(t.(climbs{i}).CumDistance,t.(climbs{i}).Elevation,1)
% f = polyval(slope1,t.(climbs{i}).CumDistance);
% plot(t.(climbs{i}).CumDistance,t.(climbs{i}).Elevation,'o',t.(climbs{i}).CumDistance,f,'-', 'Color', colors(i,:))
% legend('data','linear fit')
% hold on
% slopes(i) = slope1(1)
% end

[a, idx] = sort(slopes)
climbs = climbs(idx)





subplot(1,3,1)
colors = viridis(length(climbs))
for i = 1:length(climbs)
    plot(cumsum(t.(climbs{i}).Distance), t.(climbs{i}).Elevation, 'LineWidth', 3, 'Color', colors(i,:))
    hold on
    set(gcf,'color',[1 1 1])
    set(gca,'FontSize',16)
    xlabel('Distance (miles)')
    ylabel('Altitude (feet)')
%     xlabel('Distance (km)')
%     ylabel('Altitude (m)')
    
    set(gcf,'color',[.5 .5 .5])
    set(gca,'color',[.5 .5 .5])
end

subplot(1,3,2)
for i = 1:length(climbs)
    plot(cumsum(t.(climbs{i}).Distance), t.(climbs{i}).Elevation-t.(climbs{i}).Elevation(1), 'LineWidth', 3, 'Color', colors(i,:))
    hold on
    set(gcf,'color',[1 1 1])
    set(gca,'FontSize',16)
    xlabel('Distance (miles)')
    ylabel('Altitude (feet) from sea level')
    set(gcf,'color',[.5 .5 .5])
    set(gca,'color',[.5 .5 .5])
    ylim([0 3500])
%     xlim([0 4])
    
end
legend(climbs, 'Location','northwest')


subplot(1,3,3)
for i = 1:length(climbs)
    plot(cumsum(t.(climbs{i}).Distance), t.(climbs{i}).Elevation-t.(climbs{i}).Elevation(1), 'LineWidth', 3, 'Color', colors(i,:))
    hold on
    set(gcf,'color',[1 1 1])
    set(gca,'FontSize',16)
    xlabel('Distance (miles)')
    ylabel('Altitude (feet) from sea level')
    set(gcf,'color',[.5 .5 .5])
    set(gca,'color',[.5 .5 .5])
    ylim([0 1000])
    xlim([0 4])
    
end
save2pdf('/Users/pinheirochagas/Pedro/Stanford/code/gpx_fun/climbs.pdf',gcf, 600)
% legend('Mount Diablo', 'Mount Tam', 'Twin Peaks via 17th st', 'Twin Peaks via Portola', 'Hawk Hill', 'Spruce st.', 'Location','northwest')


a = area(Y);

a = area(cumsum(t.(climbs{i}).Distance), t.(climbs{i}).Elevation-t.(climbs{i}).Elevation(1))
a(1).FaceColor = [colors(i,:)];


for i = 1:length(climbs)-1
    dist = cumsum(t.(climbs{i}).Distance);
    el = t.(climbs{i}).Elevation;
    plot3(dist, ones(size(el))+i, el-el(1), 'LineWidth', 3, 'Color', colors(i,:))
    hold on
    set(gcf,'color',[1 1 1])
    set(gca,'FontSize',16)
    xlabel('Distance (miles)')
    zlabel('Altitude (feet) from sea level')
    set(gcf,'color',[.5 .5 .5])
    set(gca,'color',[.5 .5 .5])
    %     ylim([0 1000])
    %         xlim([0 4])
    %         zlim([0 1000])
    
end

plot3(dist, ones(size(el))+i, el-el(1)); 

[X,Y] = meshgrid(dist,el-el(1)); 
surf(X,Y,el-el(1),'EdgeColor','none');



Nactions = 5;
Ntime = 5;
x = (1:Nactions); % actions
y = (1:Ntime); % time
[X,Y] = meshgrid(x,y);
z = rand(Ntime,Nactions);
w = waterfall(X,Y,z)
w.EdgeColor = 'b';
w.EdgeAlpha = 0.5;
w.FaceColor = 'b';
w.FaceAlpha = 0.2;
xlabel('actions')
ylabel('time')
zlabel('probabilities')
title('waterfall')


    ylim([0 10])
    grid on

X = cumsum(t.(climbs{i}).Distance)
Y = t.(climbs{i}).Elevation-t.(climbs{i}).Elevation(1)
plot3(X,ones(size(X)),Y)








[X,Y] = meshgrid(dist, ones(size(el)));
Z = peaks(X,Y);
waterfall(X,Y,Z)











subplot(1,3,2)
plot(cumsum(d_it), trk_it.Elevation(1:end-1)-trk_it.Elevation(1), 'LineWidth', 3, 'Color', 'b')
hold on
plot(cumsum(d_md), trk_md.Elevation(1:end-1)-trk_md.Elevation(1), 'LineWidth', 3,  'Color', 'r')
set(gcf,'color',[1 1 1])
set(gca,'FontSize',16)
xlabel('Distance (km)')
ylabel('Altitude (m) from sea level')
legend('Itabirito', 'Mount Diablo','Location','northwest')


% Time values are stored as text in the GPX file.
% Use datenum to convert them to serial date numbers.
% Compute the time-of-day in hours-minutes-seconds.
timeStr = strrep(trk.Time,'T',' ');
timeStr = strrep(timeStr,'.000Z','');
trk.DateNumber = datenum(timeStr,31);
day = fix(trk.DateNumber(1));
trk.TimeOfDay = trk.DateNumber - day;

% Display an area plot of the elevation and time values.
figure
area(trk.TimeOfDay,trk.Elevation)
datetick('x',13,'keepticks','keeplimits')
ylabel('elevation (meters)')
xlabel('time(Z) hours:minutes:seconds')
title({'Elevation Area Plot',datestr(day)});

% Calculate and display ground track distance.
% Convert distance in meter to distance in U.S. survey mile.
e = wgs84Ellipsoid;
lat = trk.Latitude;
lon = trk.Longitude;
d = distance(lat(1:end-1),lon(1:end-1),lat(2:end),lon(2:end),e);
d = d * unitsratio('sm','meter');

% Display the cumulative ground track distance and elapsed time.
trk.ElapsedTime = trk.TimeOfDay - trk.TimeOfDay(1);
figure
line(trk.ElapsedTime(2:end),cumsum(d))
datetick('x',13)
ylabel('cumulative ground track distance (statute mile)')
xlabel('elapsed time  (hours:minutes:seconds)')
title({'Cumulative Ground Track Distance in Miles', datestr(day),  ...
    ['Total Distance in Miles: ' num2str(sum(d))]});
