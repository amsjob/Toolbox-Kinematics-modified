% mfile belonging to the documentation file
%
% o history
%   Daniel Klawitter
%   24-02-2010 - 10:04 created
%
% o summary
%       All algorithms presented in the documentation are implemented here.
%       Examples are shown. You can step through the code while working
%       through the documentation
%
% o TODO:
%



% this m-file contains the lines of code the are presented in the
% documentation.

%% Class DualNumber
% create two dual numbers
d1 = DualNumber(1,1);
d2 = DualNumber(3,4);

% operations
d1+d2
d1-d2
d1*d2
0.5.*d1
sqrt(d2)                                % or d2.sqrt
inv(d2)                                 % or d2.inv
d2*inv(d2)
conjugate(d2)                           % or d2.conjugate

%% Class Quaternion
q1 = Quaternion( 1 ,[ 1 1 1 ])
q2 = Quaternion( 2 ,[ 0 0 -1])

q1+q2
q1-q2
q1*q2
0.5.*q1
norm(q1)
normalize(q1)
conjugate(q1)

%% Class Dualquaternion
Dq1 = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(1,[0.5 0 0.5]))
Dq2 = Dualquaternion(Quaternion(0.9239,[0 0 0.3827]),Quaternion)

Dq1 + Dq2
Dq1 - Dq2
conjugate(Dq1)
dualconjugate(Dq1)

% dual Quaternion describing a pure translation with translation vector
% t=(1, 8, 1)
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0.5 4 0.5]));
% dual Quaternion describing a pure rotation
R = Dualquaternion(Quaternion(0.9239,[0 0 0.3827]),Quaternion);
Q = T*R;
Q.getTranslation
Q.getRotation

x = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[1 0 0]));
displace(Q,x)
displaceRT(Q,x)
displaceTR(Q,x)
Q.getStudyParameters
Q.normalize
Q.latex1
Q.latex2

%% Class RotationMatrix

A = RotationMatrix('EULER',[.5 .5 .5 .5])
A = RotationMatrix('GENERAL',2,[0; 0; 5])
A = RotationMatrix('RODRIGUES',[-1; 2; 1])
A = RotationMatrix('EXPONENTIAL',[0; 1; 1],pi/4)

A.toHomogeneousMatrix
A.getAngle
A.getAxis

%% Class HomogeneousVector
a = getEulerCoords(pi/4,[0 0 1]);
rotation = HomogeneousVector(a);
translation = HomogeneousVector([1 1 1 0])

rotation.normalize
power(rotation,2)
rotation.^2

dualTranslationQuaternion(translation)
rotationQuaternion(rotation)
dualRotationQuaternion(rotation)
DualSpatialDisplacementQuaternion(translation, rotation)

translation.double

%% Class HomogeneousTransformationMatrix
rotation = HomogeneousVector([0.92388 ,0 ,0 ,0.38268]);
translation = HomogeneousVector([1 1 1 0]);
A = HomogeneousTransformationMatrix(translation, rotation)

B = HomogeneousTransformationMatrix;

A*B
A*translation

%% Class STUDYparameter

par = STUDYparameter([1 0 0 0 2 3 1 9])

T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0.5 0 0.5]));
% dual Quaternion describing a pure rotation
R = Dualquaternion(Quaternion(0.9239,[0 0 0.3827]),Quaternion);
Q = T*R;
par = Q.getStudyParameters
par.getHomogeneousMatrix

%% utility functions
% get Euler coordinates form given angle and rotation axis
a = getEulerCoords(pi/4,[0 0 1])

% get homogeneous points on sphere through given azimut and altitude angles
getSphereCoords(pi/4, pi/4)

% draw a cube in the untransformed position
plotCube;
hold on;
% draw another moved cube. the motion is given through a homogeneous
% matrix, study parameters or a dual quaternion that represents a spatial
% displacement
plotCube(par);
% there is another input opportunity for thicker lines
plotCube(par,2);

%% Interpoaltion
% interpolateOnQuadric
% for more details about this function see interpolateOnQuadric.m

a = {};
controlPoints.coords = getSphereCoords(0,0);
controlPoints.value = 0;
a{1} = controlPoints;
controlPoints.coords = getSphereCoords(pi/10,-pi/12);
controlPoints.value = 0.166666666;
a{2} = controlPoints;
controlPoints.coords = getSphereCoords(pi/6,pi/8);
controlPoints.value = 0.333333332;
a{3} = controlPoints;
controlPoints.coords = getSphereCoords(pi/4,pi/4);
controlPoints.value = .5;
a{4} = controlPoints;
controlPoints.coords = getSphereCoords(pi/2,pi/2);
controlPoints.value = 0.66666666;
a{5} = controlPoints;

M = diag([-1 1 1 1]);

point1 = [];
tic
for i = 0:0.001:a{5}.value
    point1 = [point1,interpolateOnQuadric(a,i,M)];
end
toc

% normalize the points to plot them in IR^3
for i=1:size(point1,2)
    point1(:,i)=1/point1(1,i).*point1(:,i);
end

% plot the curve
sphere;
axis equal;
hold on;
X=point1(2,:);
Y=point1(3,:);
Z=point1(4,:);
plot3(X,Y,Z,'LineWidth',2);

% plot the points that are interpolated
for i=1:length(a)
    p = plot3(a{i}.coords(2),a{i}.coords(3),a{i}.coords(4));
    set(p,'Marker','.');
    set(p,'MarkerSize',30);
end

%% aitken interpoaltion in projective space, here IP^3 on the sphere

a = {};
controlPoints.coords = getSphereCoords(0,0);
controlPoints.value = 0;
a{1} = controlPoints;
controlPoints.coords = getSphereCoords(pi/10,-pi/12);
controlPoints.value = 0.166666666;
a{2} = controlPoints;
controlPoints.coords = getSphereCoords(pi/6,pi/8);
controlPoints.value = 0.333333332;
a{3} = controlPoints;
controlPoints.coords = getSphereCoords(pi/4,pi/4);
controlPoints.value = .5;
a{4} = controlPoints;
controlPoints.coords = getSphereCoords(pi/2,pi/2);
controlPoints.value = 0.66666666;
a{5} = controlPoints;


M = diag([-1 1 1 1]);

point1 = [];
tic
for i = 0:0.001:a{5}.value
    point1 = [point1,aitken(a,i,M)];
end
toc

% normalize the points to plot them in IR^3
for i=1:size(point1,2)
    point1(:,i)=1/point1(1,i).*point1(:,i);
end

% plot the curve
sphere;
axis equal;
hold on;
X=point1(2,:);
Y=point1(3,:);
Z=point1(4,:);
plot3(X,Y,Z,'LineWidth',2);

% plot the points that are interpolated
for i=1:length(a)
    p = plot3(a{i}.coords(2),a{i}.coords(3),a{i}.coords(4));
    set(p,'Marker','.');
    set(p,'MarkerSize',30);
end

%% QB-curve construction on sphere

a = {};
controlPoints.coords = getSphereCoords(0,0);
a{1} = controlPoints;
controlPoints.coords = getSphereCoords(pi/10,-pi/12);
a{2} = controlPoints;
controlPoints.coords = getSphereCoords(pi/6,pi/8);
a{3} = controlPoints;
controlPoints.coords = getSphereCoords(pi/4,pi/4);
a{4} = controlPoints;
controlPoints.coords = getSphereCoords(pi/2,pi/2);
a{5} = controlPoints;


M = diag([-1 1 1 1]);

point1 = [];
tic
for i = 0:0.001:1
    point1 = [point1,QBinterpolation(a,i,M)];
end
toc

% normalize the points to plot them in IR^3
for i=1:size(point1,2)
    point1(:,i)=1/point1(1,i).*point1(:,i);
end

% plot the curve
sphere;
axis equal;
hold on;
X=point1(2,:);
Y=point1(3,:);
Z=point1(4,:);
plot3(X,Y,Z,'LineWidth',2);

% plot the control points
for i=1:length(a)
    p = plot3(a{i}.coords(2),a{i}.coords(3),a{i}.coords(4));
    set(p,'Marker','.');
    set(p,'MarkerSize',30);
end

%% Aitken algorithm on Study's Quadric three positions

M = diag([.5 .5 .5 .5],-4) + diag([.5 .5 .5 .5],4);
a={};
% first point on the study quadric defined via dual quaternions
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0 0 0.5]));
Q = T;
controlPoints.coords = double(Q.getStudyParameters);
controlPoints.value = 0;
plotCube(Q.getStudyParameters,2);
hold on;
a{1} = controlPoints;
% second point
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[2 0 3]));
R = Dualquaternion(Quaternion(0.9239,[0 .5 0.3827]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
controlPoints.value = 0.25;
plotCube(Q.getStudyParameters,2);
a{2} = controlPoints;
% third point
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[3 -0.5 0]));
R = Dualquaternion(Quaternion( 0.9808 ,[0.1379 0 0.1379]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
controlPoints.value = 0.5;
plotCube(Q.getStudyParameters,2);
a{3} = controlPoints;

% T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0 -1.5 -2]));
% R = Dualquaternion(Quaternion( 0.9808 ,[ 0 0.1379 0.1379]),Quaternion);
% Q = T*R;
% controlPoints.coords = double(Q.getStudyParameters);
% controlPoints.value = 0.75;
% plotCube(Q.getStudyParameters,2);
% a{4} = controlPoints;
%
% R = Dualquaternion(Quaternion( 0.8660 ,[0 0.3536 0.3536]),Quaternion);
% T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[1 -1 -4]));
% Q = T*R;
% controlPoints.coords = double(Q.getStudyParameters);
% controlPoints.value = 1;
% plotCube(Q.getStudyParameters,2);
% a{5} = controlPoints;

point1 = [];
for i = 0:0.01:a{end}.value
    point1 = [point1,aitken(a,i,M)];
end

for i = 1:size(point1,2)
    h1 = plotCube(STUDYparameter(point1(:,i)));
    drawnow;
    %     delete(h1)
end

%% QB curve on Study's quadric

a={};
% first point on the study quadric defined via dual quaternions
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0 0 0.5]));
Q = T;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
hold on;
a{1} = controlPoints;
% second point
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0 0.5 4]));
R = Dualquaternion(Quaternion(0.7071,[0.4082  0.4082  0.4082]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{2} = controlPoints;
%---
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[2 0 3]));
R = Dualquaternion(Quaternion(0.9239,[0 .5 0.3827]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{3} = controlPoints;
%---
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[3 -0.5 4]));
R = Dualquaternion(Quaternion(0.9877,[0 0.1106 0.1106]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{4} = controlPoints;
%---
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[3 -0.5 0]));
R = Dualquaternion(Quaternion( 0.9808 ,[0.1379 0 0.1379]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{5} = controlPoints;

tic
point1 = [];
for i = 0:0.01:1
    point1 = [point1,QBinterpolation(a,i,M)];
end
toc

for i = 1:size(point1,2)
    h1 = plotCube(STUDYparameter(point1(:,i)));
    drawnow;
    %     delete(h1)
end

%% second example QB curve on Study's Quadric

M = diag([.5 .5 .5 .5],-4) + diag([.5 .5 .5 .5],4);

a={};
% first point on the study quadric defined via dual quaternions
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0 0 0.5]));
Q = T;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
hold on;
a{1} = controlPoints;
% second point
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[-2 0.5 6]));
R = Dualquaternion(Quaternion(0.7071,[0.4082  0.4082  0.4082]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{2} = controlPoints;
%---
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[2 0 3]));
R = Dualquaternion(Quaternion(0.9239,[0 .5 0.3827]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{3} = controlPoints;
%---
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[3 -0.5 4]));
R = Dualquaternion(Quaternion(0.8660,[0.3536  0.3536      0   ]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{4} = controlPoints;
%---
T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[3 -0.5 0]));
R = Dualquaternion(Quaternion( 0.9808 ,[0.1379 0 0.1379]),Quaternion);
Q = T*R;
controlPoints.coords = double(Q.getStudyParameters);
plotCube(Q.getStudyParameters,1.5);
a{5} = controlPoints;

point1 = [];
for i = 0:0.01:1
    point1 = [point1,QBinterpolation(a,i,M)];
end

for i = 1:size(point1,2)
    h1 = plotCube(STUDYparameter(point1(:,i)));
    drawnow;
    %     delete(h1)
end