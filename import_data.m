function [bolt_data,hole_data]=import_data(identifier)

if identifier==1
    bolt_data=xlsread('bolt_data_1');
    hole_data=xlsread('hole_data_1');
elseif identifier==2
    bolt_data=xlsread('bolt_data_2');
    hole_data=xlsread('hole_data_2');
elseif identifier==3
    bolt_data=xlsread('bolt_data_3');
    hole_data=xlsread('hole_data_3');
end
end