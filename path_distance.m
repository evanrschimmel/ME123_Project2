function [tot_distance]=path_distance(coords)

tot_distance=0; %initialize total distance to zero

[n,~]=size(coords); %calculate number of points in coordinate vector

for i=1:n-1
    tot_distance=tot_distance+ptp_distance(coords(i,1),coords(i+1,1),coords(i,2),coords(i+1,2)); %recrusive sum for total distance, using given point and next point in sequence
end