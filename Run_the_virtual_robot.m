clear all
clc

% Name of the file you created
file_to_run = 'Mini_Project_Two.txt';

% Name of the bolt data file
bolt_data = readmatrix('bolt_data_final');
hole_data = readmatrix('hole_data_final');

%--------------------------------------------------------------------------
% DO NOT CHANGE ANY CODE BELOW THIS POINT
% Read in the ROBOFORTH file
lines = textread(file_to_run,'%s','delimiter','\r');
ind = length(lines);

% Find lines in the text file with 6 numerical values; these will be moveto
% commands.  Convert to a matrix and take the last two digits as the x and
% y coordinates.
counter = 0;
status = 0;
for iline = 1:length(lines)
    line = lines{iline};
    temp = length(line);
    if length(line) == 4
        if sum(line == 'GRIP') == 4
            status = 1;
        end
    elseif length(line) == 6
        if sum(line == 'UNGRIP') == 6
            status = 0;
        end
    end
    
    if length(line) > 0;
        C = textscan(line, '%6.0f');
        C_mat = cell2mat(C);
        if size(C_mat,1) == 6;
            counter = counter + 1;
            posMat(counter,:) = [C_mat(6);C_mat(5);status];
        end
    end
end

for KK = 2:size(posMat,1)
    posStart = posMat(KK-1,:);
    posStop = posMat(KK,:);
    status = posMat(KK,3);
    
    leg_length = sqrt((posStart(1)-posStop(1))^2 + (posStart(2)-posStop(2))^2);
    xVec = linspace(posStart(1),posStop(1),ceil(leg_length/100));
    yVec = linspace(posStart(2),posStop(2),ceil(leg_length/100));
    
    for JJ = 1:length(xVec)
        figure(1)
        clf
        hold on
        set(gca,'XLim',[-1600 1600])
        set(gca,'YLim',[0 4600])
        set(gca,'ZLim',[0 2500])
        set(gca,'ZTickLabel',[]);
        axis equal
        box on
        view([210 30])
        
        patch([-2000 -2000 2000 2000],[0 4600 4600 0],[0.9 0.9 0.9])
        x_circle = 100*cosd(0:45:360);
        y_circle = 100*sind(0:45:360);
        for II = 1:size(hole_data,1)
            if hole_data(II,3) == 1
                patch(x_circle + hole_data(II,1),y_circle + hole_data(II,2),'r');
            elseif hole_data(II,3) == 2
                patch(x_circle + hole_data(II,1),y_circle + hole_data(II,2),'g');
            elseif hole_data(II,3) == 3
                patch(x_circle + hole_data(II,1),y_circle + hole_data(II,2),'b')
            end
        end
        
        if status == 1
            if JJ == 1
                xTemp = find(bolt_data(:,1) == xVec(JJ));
                yTemp = find(bolt_data(:,2) == yVec(JJ));
                rowMoving = intersect(xTemp,yTemp);
            end
            bolt_data(rowMoving,1:2) = [xVec(JJ) yVec(JJ)];
        end
        for II = 1:size(bolt_data,1)
            x0 = bolt_data(II,1);
            y0 = bolt_data(II,2);
            c0 = bolt_data(II,3);
            func_plot_bolt(x0,y0,c0);
        end
        
        func_plot_robot(xVec(JJ),yVec(JJ),200,status)
        
        if (JJ == length(xVec)) && (KK < (size(posMat,1)-1))
            if (posMat(KK+1,3) ~= status)
                func_plot_robot(xVec(JJ),yVec(JJ),200,0.5)
            end
        end
    end
    drawnow
end
