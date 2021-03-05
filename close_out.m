function close_out(com_file)

%  This function is called last.  It moves the arm to the start position
%  and it closes the command file

fprintf(com_file,'10000 SPEED !\r\n');  
fprintf(com_file,'0 0 900 -800 2000 0 CM\r\n');
fprintf(com_file,'MSECS? .\r\n');
fprintf(com_file,'HOME\r\n');
fprintf(com_file,';\r\n');
fclose(com_file);

end