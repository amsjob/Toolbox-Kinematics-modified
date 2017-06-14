function point = aitken(controlPoints, t, M)

% o history
%   Daniel Klawitter
%   05-11-2009 - 17:07 created
%   08-03-2010 - 10:05 comments, simplify
%
% o summary
%      Generalization of the aitken algoritmus (see farin - CAGD)
%      instead of affine ratios cross ratios in projective space are used
%      and in stead of three points iin affin space, four point are used
%      for one cross ratio
%
%      this algorithmus calculates one point on the hyperquadric with
%      parameter value t through subdivision
%
%      interpolate on the quadric spezified through ist Matrix M
%      this algorithmus should walk in every dimension, but the user has to
%      change the quadric matrix for his purposes
%      the matrix for a sphere is implemented and the matrix of the study
%      quadric (the image of the kinematic mapping SE(3)--> IP_7)
%      note that this algorithmus works on homogeneous coordinates
%
%      for an exmaple on the sphere see the startfiles
%
% input:  o controllPoints
%           cell Array containing struct controllPoints
%           controllPoints.coords ... coordinates on the quadric (study quadric)
%           controllPoints.value  ... the belonging value of the parameter
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

% matrix of the hyperboloid 3x^2 + 2y^2 - z^2 = 1 in IR³
% M = diag([-1 3 2 -1]);

n = length(controlPoints);

if length(controlPoints)==1
    point = controlPoints{1}.coords;
else
    
    b={};
    for i = 1:n-2
        
        b{i}.coords = lagrangePoly(controlPoints([i+1,n]),t)*lagrangePoly(controlPoints([i+1,n]),controlPoints{1}.value)*controlPoints{i+1}.coords'*M*controlPoints{n}.coords*controlPoints{1}.coords+...
            lagrangePoly(controlPoints([1,n]),t)*lagrangePoly(controlPoints([1,n]),controlPoints{i+1}.value)*controlPoints{1}.coords'*M*controlPoints{n}.coords*controlPoints{i+1}.coords+...
            lagrangePoly(controlPoints([1,i+1]),t)*lagrangePoly(controlPoints([1,i+1]),controlPoints{n}.value)*controlPoints{1}.coords'*M*controlPoints{i+1}.coords*controlPoints{n}.coords;
        b{i}.value =  controlPoints{i+1}.value;
    end
    point = aitken(b,t,M);
end
end

function res = lagrangePoly(a,value)
res = 1;
for i=1:length(a)
    res = res*(value - a{i}.value);
end

end