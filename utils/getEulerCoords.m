function [ eulerCoords ] = getEulerCoords( phi, d )
%getEulerCoords gives EULER coordinates from given angle and axis
%
% o history
%   Daniel Klawitter
%   21-10-2009 - 20:34 created
%   09-03-2010 - 10:58 comments, header
% 
% o summary
%       this function results EULER coordinates
% 
% o input
%       o phi ... the angle of the rotation
%       o d   ... the axis of the rotation
% 
% o output
%       o eulerCoords ... a vector with 4 components containing the EULER
%                         coordinates of the given rotation 
% 
% o TODO:
% 

if sum(d.^2) ~= 1
    d = 1/sqrt(sum(d.^2)) .*d;
end

eulerCoords(1)   = cos(phi/2);
eulerCoords(2:4) = sin(phi/2)*d;

end

