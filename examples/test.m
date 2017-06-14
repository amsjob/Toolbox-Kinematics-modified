% some calculations with the implemented classes

% test dual Quaternions

D = Dualquaternion(Quaternion(2,[0 0 0]),Quaternion(0,[1 1 1]));
E = Dualquaternion(Quaternion(1,[0 0 1]),Quaternion);

% test RotationMatrix class

% construct a RotationMatrix by using EULER coordinates
A = RotationMatrix('EULER',[.5 .5 .5 .5]);
% construct a RotationMatrix by giving the axis and the angle
A = RotationMatrix('GENERAL',pi/2,[0; 0; 1]);
% construct a RotationMatrix by using RODRIGUES coordinates
A = RotationMatrix('RODRIGUES',[-1; 2; 1]);
% construct a RotationMatrix by using exponential coordinates
A = RotationMatrix('EXPONENTIAL',[0; 1; 1],pi/4);




%% test spatial displacements with dual quaternions
% default constructor of class Dualquaternion
Q = Dualquaternion;

% halbe translation
% T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[.5 .5 0]));

T = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[0.5 0 0.5]));

R = Dualquaternion(Quaternion(0.9239,[0 0 0.3827]),Quaternion);
Q = T*R;
x = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion(0,[1 0 0]));
displaceRT(Q,x)
displaceTR(Q,x)
%% test study paramter functionality
    B = Q;
    plotCube();
    b={};
for i=1:10
%     hold on;
    plotCube(Q);
    b{i} = double(Q.getStudyParameters);
    Q = Q*B;
    drawnow
end
% plotCube(R.getStudyParameters.homogeneousMatrix);

%% test class HomogeneousTransformationMatrix
% Eulercoordinates from the formula E = cos(phi/2) + sin(phi/2)*r
% d = [0 0 1], phi = pi/4
a = getEulerCoords(pi/4,[0 0 1]);
rotation = HomogeneousVector(a);
translation = HomogeneousVector([1 1 1 0]);
A = HomogeneousTransformationMatrix(translation, rotation);
x = HomogeneousVector([1 1 0 0]);
A*x


%% test interpolation on sphere
% attention the matrix of the quadric has to fit in interpolateOnQuadric.m
% call aitkenPicture for subdaivision picture
M = diag([-1 1 1 1]);
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
controlPoints.coords = getSphereCoords(pi/3,pi/4);
controlPoints.value = 0.83333333;
a{6} = controlPoints;
controlPoints.coords = getSphereCoords(pi/3,pi/7);
controlPoints.value = 1;
a{7} = controlPoints;

point2 = [];
tic
for i = 0:0.001:1
%     point2 = [point2,interpolateOnQuadric(a,i,M)];
    point2 = [point2,aitken(a,i,M)];
%     point2 = [point2,QBinterpolation(a,i,M)];
end
toc

for i=1:size(point2,2)
%     point1(:,i)=1/point1(1,i).*point1(:,i);
    point2(:,i)=1/point2(1,i).*point2(:,i);
end
sphere;
axis equal;
hold on;
% X=point1(2,:);
% Y=point1(3,:);
% Z=point1(4,:);
% plot3(X,Y,Z);
X=point2(2,:);
Y=point2(3,:);
Z=point2(4,:);
plot3(X,Y,Z);

for i=1:length(a)
    p = plot3(a{i}.coords(2),a{i}.coords(3),a{i}.coords(4));
    set(p,'Marker','.');
    set(p,'MarkerSize',30);
end

% calculate point with cross ratio 0.4
point = aitken(a,0.4,M);
point = 1/point(1).*point;
p = plot3(point(2),point(3),point(4));
set(p,'Marker','.');
set(p,'MarkerSize',25);
set(p,'Color','red');
aitkenPicture(a,0.4,M);


