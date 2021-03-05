function [] = func_plot_open_gripper(x_wrist,waist_angle)

wrist_angle = pi/2 - waist_angle;

%-------------------------------------------------------------------------
% jaw one
% rotation matrices
Tz = [cos(wrist_angle) sin(wrist_angle) 0;-sin(wrist_angle) cos(wrist_angle) 0;0 0 1];

gripper_width = 70;
gripper_height = 25;

V1 = [...
    0 gripper_width/2 -gripper_height/2;
    0 gripper_width/2 gripper_height/2;
    0 -gripper_width/2 gripper_height/2;
    0 -gripper_width/2 -gripper_height/2];

for II = 1:4
    V(II,:) = (Tz*(V1(II,:) + [30 0 0])' + x_wrist)';
end
for II = 1:4
    V(II+4,:) = (Tz*(V1(II,:) + [200 0 0])' + x_wrist)';
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
    V(II,:) = (Tz*(V1(II,:) + [30 0 0])' + x_wrist)';
end
for II = 1:4
    V(II+4,:) = (Tz*(V1(II,:) + [200 0 0])' + x_wrist)';
end
F = [...
    1 2 3 4;
    1 5 6 2;
    2 6 7 3;
    3 7 8 4;
    4 8 5 1;
    5 6 7 8];

patch('Faces',F,'Vertices',V,'FaceColor',[0.7 0.7 0.7])
    
    



