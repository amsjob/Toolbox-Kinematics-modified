function side = plotCube(transformation, lineWidth)

% o history
%   Daniel Klawitter
%   created 26-10-2009 - 12:58
%
% o summary
%   function to visualize spatial displacements by ploting a cube that
%   is displaced from his "home" position into the new one
%
% o input:
%   transformation ... HomogeneousTransformationMatrix OR
%                  ... STUDYparameter OR
%                  ... Dualquaternion
%
% o Output:
%   plot of the cube in his position after the spatial displacement
%
% o structure
%
%         p2---------p1
%        /|          /|
%       p3---------p4 |
%       | |         | |
%       | |         | |
%       | p6--------p5
%       | /         |/
%       p7---------p8
%


%% cube vertecies in home position

p1 = HomogeneousVector([1;1;1;1]);
p2 = HomogeneousVector([1;-1;1;1]);
p3 = HomogeneousVector([1;-1;-1;1]);
p4 = HomogeneousVector([1;1;-1;1]);
p5 = HomogeneousVector([1;1;1;-1]);
p6 = HomogeneousVector([1;-1;1;-1]);
p7 = HomogeneousVector([1;-1;-1;-1]);
p8 = HomogeneousVector([1;1;-1;-1]);

%% apply the tarnsformation

if nargin == 0
    transformation = HomogeneousTransformationMatrix;
end

% in input is not a HomogeneousTransformationMatrix generate one
if isa(transformation,'STUDYparameter')
    transformation = transformation.getHomogeneousMatrix;
elseif isa(transformation,'Dualquaternion')
    transformation = transformation.getStudyParameters.getHomogeneousMatrix;
end

p1 = double(transformation*p1);
p2 = double(transformation*p2);
p3 = double(transformation*p3);
p4 = double(transformation*p4);
p5 = double(transformation*p5);
p6 = double(transformation*p6);
p7 = double(transformation*p7);
p8 = double(transformation*p8);

%% plot cube
% top face
side(1)=fill3([p1(2) p2(2) p3(2) p4(2)],...
    [p1(3) p2(3) p3(3) p4(3)],...
    [p1(4) p2(4) p3(4) p4(4)],[1 0 0]);
hold on;
% bottom face
side(2)=fill3([p5(2) p6(2) p7(2) p8(2)],...
    [p5(3) p6(3) p7(3) p8(3)],...
    [p5(4) p6(4) p7(4) p8(4)],[0 0.0 1]);

% other sides
side(3)=fill3([p1(2) p4(2) p8(2) p5(2)],...
    [p1(3) p4(3) p8(3) p5(3)],...
    [p1(4) p4(4) p8(4) p5(4)],[0.749 0 0.749]);
side(4)=fill3([p4(2) p3(2) p7(2) p8(2)],...
    [p4(3) p3(3) p7(3) p8(3)],...
    [p4(4) p3(4) p7(4) p8(4)],[0 1 0]);
side(5)=fill3([p3(2) p2(2) p6(2) p7(2)],...
    [p3(3) p2(3) p6(3) p7(3)],...
    [p3(4) p2(4) p6(4) p7(4)],[1 1 0]);
side(6)=fill3([p2(2) p1(2) p5(2) p6(2)],...
    [p2(3) p1(3) p5(3) p6(3)],...
    [p2(4) p1(4) p5(4) p6(4)],[0.6784 0.9216 1]);

%set transparency
alpha(side,0.6)

% set line thickness if input is there
if nargin > 1
    for i=1:6
        set(side(i), 'LineWidth',lineWidth);
    end
end

% view(3);
% axis([-3 3 -3 3 -3 3 ]);
axis equal;
% camlight;

end