function point = interpolateOnQuadric(controlPoints,t,M)
% o history
%   Daniel Klawitter
%   created 04-11-2009 - 15:10
%
% o summary
%      interpolate on the quadric spezified through ist Matrix M
%      this algorithmus should walk in every dimension, but the user has to
%      change the quadric matrix for his purposes
%      the matrix for a sphere is implemented and the matrix of the study
%      quadric (the image of the kinematic mapping SE(3)--> IP_7)
%      note that this algorithmus works on homogeneous coordinates
%
%      for an exmaple on the sphere see, doc.m
%
% input:  o controllPoints
%           cell Array containing struct controllPoints
%           controlPoints.coords ... coordinates on the quadric (study
%           quadric)
%           controlPoints.value  ... the belonging value of the parameter
% 
%           the number of controllpoints must be odd because in other case
%           there will not exist a solution (see Gfrerrer)
% 
%         o t ... the parameter value, for that the point on the interpolant
%           shall be calculated
% output: o point...the point on the interpolant at the parameter t in
%           homogeneous coordinates
%
% todo:   o if point lay on a line, take this line as solution ^^
%           only neccessary if the quadric contains straight lines
%
% literature: Gfrerrer - On the construction of rational curves on
%             hyperquadrics


% global M
% matrix of the study quadric
% M = diag([.5 .5 .5 .5],-4) + diag([.5 .5 .5 .5],4);

% matrix of the unit sphere in IR³
% M = diag([-1 1 1 1]);

% number of point that are given to the algo !!! must be an odd number
n = length(controlPoints);

point = zeros(length(controlPoints{1}.coords),1);

for i=1:n
    b = {};
    b = controlPoints([1:i-1,i+1:end]);
    
    % calculate the a_J\{i} via recursion formular
    arec = recursiveFactor(b,M);
    point = point + lagrangePoly(b,t)*lagrangePoly(b,controlPoints{i}.value)*arec * controlPoints{i}.coords;
end

end

function res = recursiveFactor(a,M)
%  input:  o a
%            control points in the actual index set
%  output: o factor fpr the rational interpolant

% global M

n = length(a);
if n==2
    % stop condition
    res = a{1}.coords'*M*a{2}.coords;
else
    % recursion
    res = 0;
    for i = 2:1:n
        scal = a{i}.coords'*M*a{1}.coords;
        tl = a{1}.value;
        tk = a{i}.value;
        b = {};
        % clear positions in vector
        b = a([2:i-1,i+1:end]);
        res = res + lagrangePoly(b,tk)*lagrangePoly(b,tl)*scal*recursiveFactor(b,M);
    end
end

end

function res = lagrangePoly(a,value)
res = 1;
for i=1:length(a)
    res = res*(value - a{i}.value);
end

end




