function aitkenPicture(a,t,M)

% o history
%   Daniel Klawitter
%   created 05-11-2009 - 22:07
%
% o summary
%      Generalization of the aitken algoritmus (see farin - CAGD)
%      calls the aitken algorithmus for every subset of points and
%      generates a plot, the user can improve it by setting colors etc
%
%      a few command should be made before this function was called...see
%      test.m
%      >> sphere;
%      >> axis equal;
%      >> plot the whole curve (could also be done later)
%
%      for an exmaple on the sphere see the startfiles
%
% input:  o a
%           cell Array containing struct controllPoints
%           controllPoints.coords ... coordinates on the quadric (study quadric)
%           controllPoints.value  ... the belonging value of the parameter
% 
%           the number of controllpoints must be odd because in other case
%           there will not exist a solution (see Gfrerrer)
% 
%         o t ... the parameter value, for that the point on the interpolant
%           shall be calculated
%         o M ... the matrix of the quadric
% output: o nice picture
%
% todo:   o 
%
% literature: Gfrerrer - On the construction of rational curves on
%             hyperquadrics

if length(a)==1
    % ih the cell array containing the points is one element plot this
    % point
    point = a{1}.coords;
    point = 1/point(1).*point;
    plot3(point(2),point(3),point(4));
else
    % new cell array for recursive call
    c = {};
    for i=2:length(a)-1
        % sub cell array
        b={};
        b{1}=a{1};
        b{2}=a{i};
        b{3}=a{end};
        point1 = [];
        
        % interpolate the subcurve
        for j = b{1}.value:0.01:b{end}.value
            point1 = [point1,aitken(b,j,M)];
        end
        
        % normalize the coords for plotting in real space
        for j=1:size(point1,2)
            point1(:,j)=1/point1(1,j).*point1(:,j);
        end
        % plot the curve
        X=point1(2,:);
        Y=point1(3,:);
        Z=point1(4,:);
        plot3(X,Y,Z);
        
        % calculate the point with cross ratio t
        point = aitken(b,t,M);
        % normalize
        point = 1/point(1).*point;
        p = plot3(point(2),point(3),point(4));
        set(p,'Marker','.');
        set(p,'MarkerSize',20);
        drawnow;
        
        % save the points with cross ration t in a new cell array
        c{i-1}.coords = point;
        c{i-1}.value = a{i}.value;
    end
    % and call this function again for the new cell array
    aitkenPicture(c,t,M);
end


end