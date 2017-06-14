function res = getSphereCoords(phi,theta)
%getSphereCoords returns homogenous coordinates for a point on the unit
%sphere
%
% o history
%   Daniel Klawitter
%   03-11-2009 - 19:26 created
%   09-03-2010 - 11:03 comments, header
% 
% o summary
%       this function returns homogeneous sphere coordinates. the
%       coordinates are calculated with the azimut and lattitude angle
% 
% o input
%       o phi     ... azimut angle
%       o theta   ... lattitude angle
% 
% o output
%       o res ... a vector with 4 components containing the sphere
%                 coordinates
% 
% o TODO:
% 

res = zeros(4,1);
res(1)=1;
res(2)=cos(theta)*cos(phi);
res(3)=cos(theta)*sin(phi);
res(4)=sin(theta);