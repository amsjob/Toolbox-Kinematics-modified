% o history
%   Daniel Klawitter
%   created 05-12-2009 - 16:45
%
% o summary
%      creates G1 spline on the sphere
% input:  o 
% output: o nice picture
% todo:   o 
%
% literature: Gfrerrer - On the construction of rational curves on
%             hyperquadrics
%             Gfrerrer - the kinematic mapping - a tool for motion design

M = diag([-1,1,1,1]);

sphere;
axis equal;
hold on;

a = {};
controlPoints.coords = getSphereCoords(-pi/3,0);
a{1} = controlPoints;
controlPoints.coords = getSphereCoords(-pi/3.5,-pi/4);
a{2} = controlPoints;
controlPoints.coords = getSphereCoords(-pi/4,-pi/7);
a{3} = controlPoints;
controlPoints.coords = getSphereCoords(-pi/8,-pi/5);
a{4} = controlPoints;
controlPoints.coords = getSphereCoords(0,0);
a{5} = controlPoints;

for i=1:length(a)
    p = plot3(a{i}.coords(2),a{i}.coords(3),a{i}.coords(4));
    set(p,'Marker','.');
    set(p,'MarkerSize',30);
end

point1 = [];

for i = 0:0.01:1
    point1 = [point1,QBinterpolation(a,i,M)];
end

for i=1:size(point1,2)
    point1(:,i)=1/point1(1,i).*point1(:,i);
end

X=point1(2,:);
Y=point1(3,:);
Z=point1(4,:);
plot3(X,Y,Z);

% X=points(2,:);
% Y=points(3,:);
% Z=points(4,:);
% plot3(X,Y,Z);

%% calculate controlpoint for the next QB-segment
tangentPoint = getTangentPoint(getSphereCoords(-pi/3,0),...
    getSphereCoords(-pi/8,-pi/5),getSphereCoords(0,0),M);
% getSphereCoords(pi/3,0) is the endpoint of the second qb-segment
% the points variable contains possible points for the second control
% structure for G1 continuity (one of this points must be the second point
% of the second control structure)
points = getQBpoints(getSphereCoords(0,0),getSphereCoords(pi/3,0), tangentPoint, M);


for i=1:size(points,2)
    p = plot3(points(2,i),points(3,i),points(4,i));
    set(p,'Marker','.');
    set(p,'MarkerSize',20);
end

% a = {};
% controlPoints.coords = getSphereCoords(-pi/3,0);
% a{1} = controlPoints;
% controlPoints.coords = getSphereCoords(-pi/8,-pi/5);
% a{2} = controlPoints;
% controlPoints.coords = getSphereCoords(0,0);
% a{3} = controlPoints;


% the second curve segments are constructed for every point in points that
% is not the startpoint of the second segment.
for i=1:size(points,2)
    if points(:,i)==a{1}.coords
        continue;
    end
    a = {};
    controlPoints.coords = getSphereCoords(0,0);
    a{1} = controlPoints;
    controlPoints.coords = points(:,i);
    a{2} = controlPoints;
    controlPoints.coords = getSphereCoords(pi/6,pi/8);
    a{3} = controlPoints;
    controlPoints.coords = getSphereCoords(pi/4,pi/12);
    a{4} = controlPoints;
    controlPoints.coords = getSphereCoords(pi/3,0);
    a{5} = controlPoints;
    
    point1 = [];
    for j = 0:0.01:1
        point1 = [point1,QBinterpolation(a,j,M)];
    end
    
    for j=1:size(point1,2)
        point1(:,j)=1/point1(1,j).*point1(:,j);
    end
    
    X=point1(2,:);
    Y=point1(3,:);
    Z=point1(4,:);
    plot3(X,Y,Z);
    
end