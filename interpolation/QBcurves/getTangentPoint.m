function point = getTangentPoint(a0,a1,a2, M)

% o history
%   Daniel Klawitter
%   created 05-12-2009 - 16:30
%
% o summary
%      function to calculate tangentpoint of a QB-curve at its endpoint
%
% input:  o a0, a1, a2 ... coordinates on the quadric Study's quadric)
%           for this function the first, the n-1 and the n. controlpoints of the
%           QB-segment are needed
%         o M ... the matrix of the quadric
% output: o point...tangent point at the end of a QB-segment
%
% literature: Gfrerrer - On the construction of rational curves on
%             hyperquadrics


point = 0.1875*a1'*M*a2*a0 -0.1875*a0'*M*a2*a1 + 0.3125*a0'*M*a1*a2;

point=1/point(1).*point;




