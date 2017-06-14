% Aitken's algorithm in affine space
% 
% o history
%   Daniel Klawitter
%   30-12-2009 - 18:49 created
%   09-03-2010 - 10:02 comments, header
% 
% o summary
%       Startfile for Aitken' algorithm in affine space.
%       Gerald Farin - Curves and surfaces for CAGD, A pratical guide
%       p. 95 - 98
% 
% 
% o TODO:
% 

figure;
hold on

t=[0;0.25;0.75;1];
for i=1:length(coords)
       point = plot(coords{i}.x,coords{i}.y);
       set(point,'Marker','.');
       set(point,'MarkerSize',20);
end

coords{1}.x = 0;
coords{1}.y = 0;

coords{2}.x = 0.5;
coords{2}.y = 4;

coords{3}.x = 4;
coords{3}.y = 3;

coords{4}.x = 5;
coords{4}.y = 0;

para=[0;0.25;0.75;1];

x=[];
y=[];
for i=0:0.01:1
    s=aitkenAffine(coords,para,i,1);
    x=[x,s.x];
    y=[y,s.y];
end

plot(x,y);