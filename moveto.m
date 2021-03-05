function moveto(com_file,x,y)

%  Issues a move command in ROBOFORTH.  The command is written to a file
%  with the identifier com-file.  The values must be scaled.

% Speed is lowered for traverse
fprintf(com_file,'5000 SPEED !\r\n');   
% The move command in ROROFORTH is written to a file.
fprintf(com_file,'0 0 900 %5.0f %5.0f %5.0f CM\r\n', -800, y, x);

end