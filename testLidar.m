rosinitIfNotActive

scan = rossubscriber("scan");
% while true
scan_data = readScan(scan);
pose = [0,0,0];
room_data = scanToGlobalFrame(scan_data,pose);
%     room_data = scanToNeatoFrame(scan_data);

clf
scatter(room_data(:,1),room_data(:,2),"filled")
axis equal;
writematrix(scan_data,"data/scan1.csv")
% end