function [] = func_plot_bolt(x0,y0,c0)

if c0 == 1
    c = 'r';
elseif c0 == 2
    c = 'g';
elseif c0 == 3
    c = 'b';
end

h = 80;
r = 20;
R = 30;
H = 30;
[X,Y,Z] = cylinder(r,4);
X = X + x0;
Y = Y + y0;
Z = h*Z;
for II = 1:6
    V(II,:) = [R*cosd((II-1)/6*360) R*sind((II-1)/6*360) h] + [x0 y0 0];
end
for II = 7:12
    V(II,:) = [R*cosd((II-7)/6*360) R*sind((II-7)/6*360) h+H] + [x0 y0 0];
end
F1 = [1 2 3 4 5 6];
F2 = [...
    1 2 8 7;
    2 3 9 8;
    3 4 10 9;
    4 5 11 10;
    5 6 12 11;
    6 1 7 12];
F3 = [7 8 9 10 11 12];

surf(X,Y,Z,'FaceColor',c,'EdgeAlpha',1)
patch('Faces',F1,'Vertices',V,'FaceColor',c)
patch('Faces',F2,'Vertices',V,'FaceColor',c)
patch('Faces',F3,'Vertices',V,'FaceColor',c)
