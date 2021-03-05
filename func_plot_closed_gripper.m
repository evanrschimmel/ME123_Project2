function [] = func_plot_cycle_gripper(x_wrist,waist_angle)

wrist_angle = pi/2 - waist_angle;

gripper_angle_vec = linspace(0,pi/2,10);
for JJ = 1:length(gripper_angle_vec)
    gripper_angle = gripper_angle_vec(JJ);
    
    %-------------------------------------------------------------------------
    % jaw one
    % rotation matrices
    Ty = [cos(gripper_angle) 0 -sin(gripper_angle);0 1 0;sin(gripper_angle) 0 cos(gripper_angle)];
    Tz = [cos(wrist_angle) sin(wrist_angle) 0;-sin(wrist_angle) cos(wrist_angle) 0;0 0 1];
    
    gripper_width = 70;
    gripper_height = 25;
    
    V1 = [...
        0 gripper_width/2 -gripper_height/2;
        0 gripper_width/2 gripper_height/2;
        0 -gripper_width/2 gripper_height/2;
        0 -gripper_width/2 -gripper_height/2];
    
    for II = 1:4
        V(II,:) = (Tz*(Ty*V1(II,:)' + [30;0;0]) + x_wrist)';
    end
    for II = 1:4
        V(II+4,:) = (Tz*(Ty*V1(II,:)' + [30+170*cos(gripper_angle);0;-170*sin(gripper_angle)]) + x_wrist)';
    end
    F = [...
        1 2 3 4;
        1 5 6 2;
        2 6 7 3;
        3 7 8 4;
        4 8 5 1;
        5 6 7 8];
    
    patch('Faces',F,'Vertices',V,'FaceColor',[0.7 0.7 0.7])
    
    %-------------------------------------------------------------------------
    % jaw one
    % rotation matrices
    Tz = [cos(wrist_angle+pi) sin(wrist_angle+pi) 0;-sin(wrist_angle+pi) cos(wrist_angle+pi) 0;0 0 1];
    
    for II = 1:4
        V(II,:) = (Tz*(Ty*V1(II,:)' + [30;0;0]) + x_wrist)';
    end
    for II = 1:4
        V(II+4,:) = (Tz*(Ty*V1(II,:)' + [30+170*cos(gripper_angle);0;-170*sin(gripper_angle)]) + x_wrist)';
    end
    F = [...
        1 2 3 4;
        1 5 6 2;
        2 6 7 3;
        3 7 8 4;
        4 8 5 1;
        5 6 7 8];
    
    patch('Faces',F,'Vertices',V,'FaceColor',[0.7 0.7 0.7])
end





