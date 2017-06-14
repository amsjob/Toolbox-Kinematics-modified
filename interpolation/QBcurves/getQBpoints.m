function points = getQBpoints(a0,a1,t, M)

% o history
%   Daniel Klawitter
%   created 05-12-2009 - 15:43
%
% o summary
%      function to calculate control point for the next QB-segment with G1
%      connection      
%
%      for an example on the sphere see the documentation
% 
% calculate the point of the next qb segment that has the same tangent at
% the connection point
%
%
%
%         o------o-----o
%        /              \
%       /                \
%      /                  \
%     o                    P                   o
%                           \                 /
%                            \               /
%                             \             /
%                              X-----o-----o
%
%   the tangent in point P is given to this function. calculation are just
%   on the second segment that shall get the tangent in its startpoint. the
%   point X is the result of this function
%
% input:  o controllPoints
%           a0, a1 ... coordinates on the quadric (Study's quadric)
%                      these points are the startpoint, the endpoint of
%                      the following QB-segment and the point
%           t      ... the tangent at the endpoint of the
%                      previous QB-segment
% 
%         o M     ... the matrix of the quadric
% output: o points... vector containing the section between the plane
%                     lambda*a0 + mue*a1 + nue*t and the quadric
%
% literature: Gfrerrer - On the construction of rational curves on
%             hyperquadrics
% 
% lamda, mue and nue are projective coordinates of the conicsection, change
% them to get other points and other G1 continuity segments
%
%
% for i=1:length(controlPoints)
%     p = plot3(controlPoints{i}.coords(2),controlPoints{i}.coords(3),controlPoints{i}.coords(4));
%     set(p,'Marker','.');
%     set(p,'MarkerSize',20);
% end

% nue^2*<t,t> + 2*lambda*mue*<a0,a1> + 2*mue*nue*<a1,t>
lambda = 1;
points = [];

for nue=0:0.1:10
    mue = -nue^2*(t'*M*t)/(2*(a0'*M*a1 + nue*a1'*M*t)); 
    points = [points,lambda*a0 + mue*a1+nue*t];
end

% normalize
for i=1:size(points,2)
    points(:,i)=1/points(1,i).*points(:,i);
end