function [] = func_plot_robot(x,y,z,status)

% robot parameters
arm_length = 2250;
waist_angle = atan2(y,x);

% N-R parameters
tol = 1e-6;
maxIter = 100;
toggle = 0;

% solve for the position of the elbow
elbow_R = sqrt(x^2 + y^2)/2;
elbow_h = sqrt(arm_length^2 - elbow_R^2);


% coords of the base, the elbow, and the wrist
x_base = [0;0;0];
x_elbow = [elbow_R*cos(waist_angle); elbow_R*sin(waist_angle); elbow_h];
x_wrist = [x;y;z];

% plot the first arm
arm_width = 40;
arm_height = 120;
func_plot_robot_arm(x_base,x_elbow,arm_length,arm_width,arm_height)

% plot the second arm
arm_width = 30;
arm_height = 90;
func_plot_robot_arm(x_elbow,x_wrist,arm_length,arm_width,arm_height)

% plot the base
[xs,ys,zs] = sphere;
surf(250*xs,250*ys,250*zs,'FaceColor',[0.4 0.4 0.4],'EdgeAlpha',0)

% plot the elbow joint
surf(100*xs+x_elbow(1),100*ys+x_elbow(2),100*zs+x_elbow(3),'FaceColor',[0.4 0.4 0.4],'EdgeAlpha',0)

% plot the wrist joint
surf(75*xs+x_wrist(1),75*ys+x_wrist(2),75*zs+x_wrist(3),'FaceColor',[0.4 0.4 0.4],'EdgeAlpha',0)

if status == 0
    func_plot_open_gripper(x_wrist,waist_angle)
elseif status == 1
    func_plot_closed_gripper(x_wrist,waist_angle)
elseif status == 0.5
    func_plot_cycle_gripper(x_wrist,waist_angle)
end




