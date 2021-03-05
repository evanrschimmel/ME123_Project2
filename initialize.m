function com_file = initialize(name)

% Open the text file for writing
% in the append mode.  First blip out
% any previous version of the file

comfile = fopen(name, 'wt');
fclose(comfile);
com_file = fopen(name,'at');

% Issue initial commands to the robot

fprintf(com_file,': PROJ2\r\n');
fprintf(com_file,'CARTESIAN\r\n');
fprintf(com_file,'10000 SPEED !\r\n');  
fprintf(com_file,'0 0 900 -800 2000 0 CM\r\n');
fprintf(com_file,'RESETMS\r\n');
fprintf(com_file,'MSECS? .\r\n');
end