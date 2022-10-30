


p = gpxread('/Users/pinheirochagas/Downloads/Serra Itabirito.gpx')

lat = p.Latitude;
lon = p.Longitude;
d = distance(lat(1:end-1),lon(1:end-1),lat(2:end),lon(2:end),e);
d = d * unitsratio('sm','meter');










[col_idx, colors_plot] = vals2colormap(p.Elevation, 'RdBu', [10 260]);


figure('units', 'normalized', 'outerposition', [0 0 .25 1]) % [0 0 .6 .3]
v = [-89.9993,10];
view(v)
cols = viridis(length(p.Latitude))

load('cdcol_2018.mat')
% plot3(p.Latitude(i:i+1), p.Longitude(i:i+1), p.Elevation(i:i+1), 'LineWidth', 2, 'Color', colors_plot(i,:))
figure('units', 'normalized', 'outerposition', [0 0 .25 1]) % [0 0 .6 .3]

km = 0
for i = 1:length(p.Time)-1
    %     plot3(p.Latitude(i:i+1), p.Longitude(i:i+1), p.Elevation(i:i+1), 'LineWidth', 2, 'Color', colors_plot(i,:))
    
    subplot(5,1,1:3)
        hold on

%     plot3(p.Latitude, p.Longitude, p.Elevation, 'LineWidth', 2, 'Color', [.5 .5 .5])
    xlim([37.7000   37.7800])
    ylim([-122.5200 -122.4200])
    zlim([0   1000])
    plot3(p.Latitude(i:i+1), p.Longitude(i:i+1), p.Elevation(i:i+1), 'LineWidth', 3, 'Color', colors_plot(i,:))
    xlim([37.7000   37.7800])
    ylim([-122.5200 -122.4200])
    zlim([0   615])
    view(i/10,10)
    
%     [d1km d2km]=lldistkm(latlon1,latlon2)

    grid on
    
    set(gcf,'color',[.5 .5 .5]);
    set(gca,'color',[.5 .5 .5]);
    set(gca,'YTickLabel',[])
    set(gca,'XTickLabel',[])
    set(gca,'ZTick',[0 610])
    set(gca,'ZTickLabel',{'0', '2,000'})
    set(gca,'fontsize',16)
    xlabel('Latitude')
    ylabel('Longitude')
    zlabel('Elevation in ft')
    title('7 sisters with GGTC')
    
    
%     kmtmp = lldistkm([p.Latitude(i) p.Longitude(i)], [p.Latitude(i+1) p.Longitude(i+1)]);
%     km = num2str(km+kmtmp);
%     km = km(1:5);
    
%     if i >= find(p.Elevation > 270, 1)
%         text(p.Latitude(find(p.Elevation > 270, 1)), p.Longitude(find(p.Elevation > 270, 1)), max(p.Elevation)+10, 'Twin Peaks', 'FontSize', 15, 'Color',[.2 .2 .2])
%     else
%     end
    
%     if i >= 1896
%         text(p.Latitude(i), p.Longitude(i), p.Elevation(i)+10, 'Croissant', 'FontSize', 15, 'Color', cols(end,:), 'HorizontalAlignment', 'Center')
%     else
%     end
%     
    hold on
    subplot(5,1,4:5)
    plot([i i+1],p.Elevation(i:i+1), 'LineWidth', 2, 'Color', colors_plot(i,:))
    set(gcf,'color',[.5 .5 .5]);
    set(gca,'color',[.5 .5 .5]);
    set(gca,'fontsize',16)
    hold on
    ylim([0 610])
    xlim([0 6668])
    grid off
    set(gca,'YTick',[0 610])
    set(gca,'XTick',[0 6668])
    xlabel('Miles')
    set(gca,'XTickLabel',{'0', '63'})
    set(gca,'YTickLabel',{'0', '2,000'})

    box off
    ylabel('Elevation in ft.')
      pause(0.0001)
      
    
end
% [d1km d2km]=lldistkm(p.Latitude(i:i+1), p.Longitude(i:i+1))
plot3(p.Latitude, p.Longitude, p.Elevation, 'LineWidth', 2)

for i = 1:length(p.Time)-1
    plot([i i+1],p.Elevation(i:i+1), 'LineWidth', 2, 'Color', colors_plot(i,:))
    set(gcf,'color',[.5 .5 .5]);
    set(gca,'color',[.5 .5 .5]);
%     axis off
    hold on
    pause(0.01)
    ylim([0 300])
    xlim([0 1600])
    axis off
    

end



[d1km d2km]=lldistkm(latlon1,latlon2)

    plot3(p.Latitude, p.Longitude, p.Elevation, 'LineWidth', 2)




LatLon = [p.Latitude;p.Longitude];                               % Create (2x21) Data Array (Decimal Degrees)
Time = [1:length(p.Latitude)]';                                               % Sampling Times
dLatLon = diff(LatLon');                                            % Convert To (21x2) & Take Successive Differences
DistDeg = hypot(dLatLon(:,1), dLatLon(:,2));                        % Distance (Degree Differences)
d2m = 4E+7/360;                                                     % Degrees-To-Metres Conversion (Approximate)
DistMtr = DistDeg * d2m;                                            % Distance (Metre Differences)
dTime = diff(Time);                                                 % Sampling Time Differences
Velocity = DistMtr ./ dTime;  


proj = geotiffinfo('/Users/pinheirochagas/Downloads/data/SF1852_wgs84.tif');
mstruct = geotiff2mstruct(proj);
R.XWorldLimits = R.XWorldLimits * proj.UOMLengthInMeters;
R.YWorldLimits = R.YWorldLimits * proj.UOMLengthInMeters;







dateandtime = datenum(p.Time{2}, 'yyyy-dd-mm HH:MM:SS');



gps2utc(p.Time{2})


p.Time{3}


'2021-07-08T14:20:50.000Z'