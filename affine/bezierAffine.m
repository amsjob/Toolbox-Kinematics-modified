function res = bezierAffine(coords,k)

% Bèzier's algorithm in affine space
% 
% o history
%   Daniel Klawitter
%   09-03-2010 - 10:01 created
% 
% o summary
%       De Casteljau algorithm in affine space
%       Gerald Farin - Curves and surfaces for CAGD, A pratical guide
%       p. 43
% 
% o input
%       o coords ... cell array containing x and y value
%       o k      ... parameter value where the point on the interpolating curve shall be
%                    calculated
% 
% o output
%       o res    ... struct containing x and y value for the parameter
%                    value k
% 
% o TODO:
% 
% o example: see start_bezier.m


if length(coords)==1
    res = coords{1};
else
    for i=1:length(coords)-1
        a{i}.x = (1 - k) *coords{i}.x + (k)*coords{i+1}.x;
        a{i}.y = (1 - k)*coords{i}.y + k*coords{i+1}.y;
    end
    res = bezierAffine(a,k);
end