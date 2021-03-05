function pickup(com_file)

%  This moves the pincers to the table and picks up the object
%  and then moves back to the operating level

fprintf(com_file,'10000 SPEED !\r\n');
fprintf(com_file,'0   0   -800 MOVE\r\n');  %moves down
fprintf(com_file,'GRIP\r\n');              %picks up object
fprintf(com_file,'0   0    800 MOVE\r\n');

end
