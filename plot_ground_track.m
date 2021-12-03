% function plot_ground_track()

function plot_ground_track(ground_track)
    img = imread('earth.png');
    image('CData',img,'XData',[-180 180],'YData',[90 -90])
    hold on
    
    ground_track = ground_track*180/pi;
    scatter(ground_track(1,:),ground_track(2,:),1,'cyan');
    axis equal
    xlabel('longitude');
    ylabel('latitude');
    xlim([-180 180]);
    ylim([-90 90]);
end