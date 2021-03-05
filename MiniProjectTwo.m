%****************************************************************
%   MiniProjectTwo.m
%
%   PROGRAM DESCRIPTION
%   This program controls a robotic arm to relocate bolts.
%
%   INPUT: None
%   OUTPUT: Resultant code to text file
%
%   WRITTEN BY: Evan Schimmel
%               01/26/2021 12:00
%
%****************************************************************

clc
clear variables
close all

file_number=fopen('MiniProjectTwo.txt','w');

bolt_data=xlsread('bolt_data_final'); %read in bolt data
hole_data=xlsread('hole_data_final'); %read in hole data

[bolt_data,hole_data]=identify_location(bolt_data,hole_data); %create new bolt and hole data sets with correct bolt/holes removed

[n_bolts,~]=size(bolt_data); %calculate number of bolts that need to be placed

file_ID=initialize('MiniProjectTwo.txt');

point=0; %initialize coordinate number to zero

point=point+1; %set the starting point as coordinate one
x=0;
y=2000;
coords(point,1)=x; %create starting point x
coords(point,2)=y; %create starting point y

for bolt=1:n_bolts %iterate the placement sequence over all the bolts
    for i=1:n_bolts
        dist(i)=ptp_distance(x,bolt_data(i,1),y,bolt_data(i,2)); %calculate distance from starting point or hole to the next bolt
    end
    [~,index]=min(dist); %minimize distance
    moveto(file_ID,bolt_data(index,1),bolt_data(index,2)); %move to closest point
    pickup(file_ID); %pick up bolt
    point=point+1; %iterate the current point as the current coordinate
    x=bolt_data(index,1);
    y=bolt_data(index,2);
    coords(point,1)=x; %add x location to coords vector
    coords(point,2)=y; %add y location to coords vector
    bolt_data(index,1)=1e15; %set data point to something large so that we don't go back to it
    bolt_data(index,2)=1e15; %set data point to something large so that we don't go back to it
    for i=1:n_bolts
        if bolt_data(index,3)==hole_data(i,3)
            dist(i)=ptp_distance(x,hole_data(i,1),y,hole_data(i,2)); %calculate distance from the current bolt pickup location to each hole option
        else
            dist(i)=1e15; %if colors don't match, ignore for distance purposes
        end
    end
    [~,index]=min(dist); %minimize distance
    moveto(file_ID,hole_data(index,1),hole_data(index,2)); %move to closest point
    putdown(file_ID); %put down bolt
    point=point+1; %iterate the current point as the current coordinate
    x=hole_data(index,1);
    y=hole_data(index,2);
    coords(point,1)=x; %add x location to coords vector
    coords(point,2)=y; %add y location to coords vector
    hole_data(index,1)=1e15; %set data point to something large so that we don't go back to it
    hole_data(index,2)=1e15; %set data point to something large so that we don't go back to it
end

point=point+1; %iterate the current point as the current coordinate
x=0;
y=2000;
coords(point,1)=x; %establish final point as the closeout x location
coords(point,2)=y; %establish final point as the closeout y location

close_out(file_ID);

tot_distance=path_distance(coords); %find the total distance traveled using the coordinate array

fclose(file_number);