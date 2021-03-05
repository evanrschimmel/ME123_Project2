function [] = func_plot_robot_arm(x_1,x_2,arm_length,arm_width,arm_height)

% radial position in the x-y plane
R = sqrt((x_1(1) - x_2(1))^2 + (x_1(2) - x_2(2))^2);
h = sqrt(arm_length^2 - (R/2)^2);

% compute arm angles
phi = atan2((x_2(2) - x_1(2)),(x_2(1) - x_1(1)));           % in the x-y plane
theta = atan2((x_2(3) - x_1(3)),R);

% rotation matrices
Ty = [cos(theta) 0 sin(theta);0 1 0;-sin(theta) 0 cos(theta)];
Tz = [cos(phi) sin(phi) 0;-sin(phi) cos(phi) 0;0 0 1];

V1 = [...
    0 arm_width/2 -arm_height/2;
    0 arm_width/2 arm_height/2;
    0 -arm_width/2 arm_height/2;
    0 -arm_width/2 -arm_height/2];

for II = 1:4
    V(II,:) = (Tz*Ty*V1(II,:)' + x_1)';
end
for II = 1:4
    V(II+4,:) = (Tz*Ty*V1(II,:)' + x_2)';
end
F = [...
    1 2 3 4;
    1 5 6 2;
    2 6 7 3;
    3 7 8 4;
    4 8 5 1;
    5 6 7 8];

patch('Faces',F,'Vertices',V,'FaceColor',[0.6 0.6 0.6])