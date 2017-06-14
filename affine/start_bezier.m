% Aitken's algorithm in affine space
% 
% o history
%   Daniel Klawitter
%   19-01-2010 - 16:20 created
% 
% o summary
%       Startfile for De Casteljau algorithm in affine space.
%       Gerald Farin - Curves and surfaces for CAGD, A pratical guide
%       p. 43
% 
% 
% o TODO:
% 

coords{1}.x=0;
coords{1}.y=0;

coords{2}.x=0.5;
coords{2}.y=4;

coords{3}.x=4;
coords{3}.y=3;

coords{4}.x=5;
coords{4}.y=0;

figure;
hold on;

for i=1:length(coords)
       point = plot(coords{i}.x,coords{i}.y);
       set(point,'Marker','.');
       set(point,'MarkerSize',20);
end

x=[];
y=[];
for i=0:0.01:1
    s=bezierAffine(coords,i);
    x=[x,s.x];
    y=[y,s.y];
end

plot(x,y);

