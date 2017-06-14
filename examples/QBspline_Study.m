% o history
%   Daniel Klawitter
%   created 03-02-2010 - 10:41
%
% o summary
%      this m file creates a G1 continuity between two QB curves on Study's
%      quadric
%
% input:  o 
% output: o nice picture
% todo:   o 
%
% literature: Gfrerrer - On the construction of rational curves on
%             hyperquadrics
%             Gfrerrer - the kinematic mapping - a tool for motion design

%% input for QB curve in study quadric

 M = diag([.5 .5 .5 .5],-4) + diag([.5 .5 .5 .5],4);

 
 %% erstes QB-segment
a={};
% firts point on the study quadric defined via dual quaternions
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0 0 0.5]));
Q = T;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
hold on;
a{1} = controlPoints;

T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[2 0 -2]));
% R = Dualquaternion(Quaternion(0.9239,[0 .5 0.3827]),Quaternion);
R = Dualquaternion(Quaternion(0.9914 ,[0 0 0.1305]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
a{2} = controlPoints;

T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[4 0 -0.5]));
R = Dualquaternion(Quaternion(0.7071,[0.4082  0.4082  0.4082]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
a{3} = controlPoints;

T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[6 0 2]));
R = Dualquaternion(Quaternion(0.8660,[0.3536  0  0.3536]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
a{4} = controlPoints;

T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[8 0.5 0]));
R = Dualquaternion(Quaternion(0.8660,[0.3536  0.3536      0   ]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
a{5} = controlPoints;


% interpolate first segment
point1 = [];
for i = 0:0.02:1
    point1 = [point1,QBinterpolation(a,i,M)];
end
for i = 1:size(point1,2)
    h1 = plotCube(STUDYparameter(point1(:,i)));
    drawnow;
%     delete(h1)
end

%% second segment

b={};
% firts point on the study quadric defined via dual quaternions

b{1} = a{5};

% controlPoints.coords = points;
% plotCube(STUDYparameter(points),1.5);
% a{2} = controlPoints;
% % 

T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[12 0 1]));
R = Dualquaternion(Quaternion( 0.0 ,[0.2425 0.9701 0]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
b{3} = controlPoints;
% 
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[14 .5 -1]));
R = Dualquaternion(Quaternion( 0.0 ,[0.2425 0 0.9701]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
b{4} = controlPoints;
% 
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[16 -0.5 1]));
R = Dualquaternion(Quaternion( 0.0 ,[0.2425 0.9701 0]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,2);
b{5} = controlPoints;

%% calculate controlpoint for the next QB-segment

endPoint = b{5}.coords;

tangentPoint = getTangentPoint(a{1}.coords,...
    a{4}.coords,a{5}.coords,M);
points = getQBpoints(a{5}.coords, endPoint, tangentPoint, M);

% in getQBpoint nue=0:0.1:10
% b{2}.coords=points(:,30);
% b{2}.coords=points(:,10);
% in getQBpoint nue=-10:0.1:0
b{2}.coords=points(:,10);
plotCube(STUDYparameter(b{2}.coords),2);


%%

point1 = [];
for i = 0:0.02:1
    point1 = [point1,QBinterpolation(b,i,M)];
end

for i = 1:size(point1,2)
    h1 = plotCube(STUDYparameter(point1(:,i)));
    drawnow;
%     delete(h1)
end
