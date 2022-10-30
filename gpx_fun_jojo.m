
addpath(genpath('/Users/pinheirochagas/Pedro/Stanford/code/gpx_fun/'))


% Load some routes 
p = {};
r = gpxread('/Users/pinheirochagas/Downloads/tennessee_valley_10miles.gpx');
p{1} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/Montara.gpx');
p{2} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/ross.gpx');
p{3} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/tennessee_valley.gpx');
p{4} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/pantoll.gpx');
p{5} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/50k_-_Golden_Gate_Trail_Classic.gpx');
p{6} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/Long_from_Ross_w_Jojo_Carmen_and_s_.gpx');
p{7} = update_gpx(r);

routes = {'Tennesse 10mi', 'Montara Half', 'Baldy Lakes', 'Tennesse 13mi', 'Cardiac 15', 'GGTC 50K', 'Long from Ross'}



% Calculate elevation gain
dist = [];
eg = [];
for i = 1:length(p)
   diff_r = diff(p{i}.e);
   eg(i) = sum(diff_r(diff_r>0));
   dist(i) = max(p{i}.d);
end
% Sort routes by elevation gain
[~ , idx] = sort(eg);
eg = eg(idx);
routes = routes(idx);
p = p(idx);
dist = dist(idx);

% Plot routes
cols = flip(magma(length(routes)));
for i = 1:length(p)

    plot(p{i}.d(1:end-1), p{i}.e(1:end-1), 'LineWidth', 4, 'Color', cols(i,:))
    hold on

end
col_bg = [.5 .5 .5];
set(gcf,'color',col_bg);
set(gca,'color',col_bg);
set(gca,'fontsize',30)
xlim([0, 31])
xlabel('Distance mi')
ylabel('Elevation ft')
legend(routes, 'FontSize', 20, 'Box', 'off')
save2pdf('routes.pdf', gcf, 600)

% Plot Elevation Gain / Distance
c = bar(eg./dist);
ylabel('Elevation Gain / Distance')
c.FaceColor = 'flat';
for i = 1:size(c.CData,1)
    c.CData(i,:) = cols(i,:);
end
set(gcf,'color',col_bg);
set(gca,'color',col_bg);
set(gca,'fontsize',30)
xticklabels(routes)
xtickangle(45)
axis square
save2pdf('eg_by_dist.pdf', gcf, 600)


%% Plot routes on map 2D
% Load some routes
p = {};
r = gpxread('/Users/pinheirochagas/Downloads/Cardiac 15.gpx');
p{1} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/Full Lakes Loop.gpx');
p{1} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/Long from Ross.gpx');
p{2} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/Sunnyside.gpx');
p{3} = update_gpx(r);
r = gpxread('/Users/pinheirochagas/Downloads/Baldy Yolanda Phoenix.gpx');
p{4} = update_gpx(r);

plot(p{1}.Latitude, p{1}.Longitude, 'LineWidth', 3)
% Plot combined on a map
geoplot(p{2}.Latitude, p{2}.Longitude, p{1}.Latitude, p{1}.Longitude, p{3}.Latitude, p{3}.Longitude, p{4}.Latitude, p{4}.Longitude, 'LineWidth', 3)

% Change terrain
geobasemap satellite

%% Plot routes in 3D
cols = hsv(length(p));
uif = uifigure;
g = geoglobe(uif);
hold(g, 'on')
for i = 1:length(p)
    geoplot3(g,p{i}.Latitude, p{i}.Longitude,p{i}.Elevation+50, 'c', 'Color', cols(i,:), 'LineWidth', 3, 'HeightReference','ellipsoid')
end


%% Load all routes from the trail program
route_files = dir(fullfile('/Users/pinheirochagas/Pedro/Stanford/code/gpx_fun/trail_running'))
route_files = route_files (4:end);


p = {};
for i = 1:length(route_files)
    file = [route_files(i).folder, '/', route_files(i).name];
    r = gpxread(file);
    p{i} = update_gpx(r);
end

cols = parula(length(p));

for i = 1:length(p)
    plot(p{i}.Latitude, p{i}.Longitude, 'LineWidth', 3, 'Color', cols(i,:))

%     diff_r = diff(p{i}.e);
%     plot(cumsum(diff_r(diff_r>0 & diff_r<150)), 'LineWidth', 3, 'Color', cols(i,:))
    hold on
end
legend(routes, 'FontSize', 20, 'Box', 'off')

uif = uifigure;
g = geoglobe(uif);
hold(g, 'on')
for i = 1:length(p)
    geoplot3(g,p{i}.Latitude, p{i}.Longitude,p{i}.Elevation+50, 'c', 'Color', cols(i,:), 'LineWidth', 1, 'HeightReference','ellipsoid')
end


plot3(p{1}.Latitude, p{1}.Longitude, p{1}.Elevation, 'LineWidth', 0.1, 'Color', 'w')

cols = jet(length(p{1}.Elevation));
hold on
for i = 1:length(p{1}.Elevation)
    plot3(p{1}.Latitude(i), p{1}.Longitude(i), p{1}.Elevation(i), 'Marker', '.', 'MarkerSize', 10, 'Color', cols(i,:))
    pause(0.0001)
end



