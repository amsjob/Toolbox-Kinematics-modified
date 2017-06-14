function res = aitkenAffine(coords,para,k, depth)
% Aitken's algorithm in affine space
% 
% o history
%   Daniel Klawitter
%   30-12-2009 - 18:51 created
%   09-03-2010 - 10:01 comments, header
% 
% o summary
%       Aitken' algorithm in affine space, see for example 
%       Gerald Farin - Curves and surfaces for CAGD, A pratical guide
%       p. 95 - 98
% 
% o input
%       o coords ... cell array containing x and y value
%       o para   ... parameter values for the point defined in coords
%       o k      ... parameter value where the point on the interpolating curve shall be
%                    calculated
%       o depth  ... depth of recursion 1 in the first call
% 
% o output
%       o res    ... struct containing x and y value for the parameter
%                    value k
% 
% o TODO:
% 
% o example: see start_aitken.m


if length(coords)==1
    res = coords{1};
else
    for i=1:length(coords)-1
        a{i}.x = (para(i+depth) - k)/(para(i+depth) - para(i))*coords{i}.x + (k - para(i))/(para(i+depth) - para(i))*coords{i+1}.x;
        a{i}.y = (para(i+depth) - k)/(para(i+depth) - para(i))*coords{i}.y + (k - para(i))/(para(i+depth) - para(i))*coords{i+1}.y;
        
        %         the following lines are for a detailed picture of the algorithms
        %         workflow (plot the lines and the points that are calculated due to the ratios)
        %         line([coords{i}.x a{i}.x],[coords{i}.y a{i}.y]);
        %         point = plot(a{i}.x,a{i}.y);
        %         set(point,'Marker','.');
        %         set(point,'MarkerSize',20);
    end
    depth = depth+1;
    res = aitkenAffine(a,para,k, depth);
end
