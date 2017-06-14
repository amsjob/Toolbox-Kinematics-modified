close all;
clear all;
clc;

Time = 0.0;
dt = 0.01;


figure

while Time < 15
   
    theta = sin(Time);
    ang = theta*pi/180;

    c = cos(ang);
    s = sin(ang);

    a = [1;0;0];
    R = [c -s 0; s c 0; 0 0 1];
    b = R*a;

    axb = cross(a,b);

    k = axb/norm(axb);

    Q1 = [0.1;0.1;0.1]*10;
    Q2 = [-0.1;-0.1;-0.1]*10;

    n_1 = cross(a,k);
    n_2 = cross(b,k);


    C1 = (Q1'+ (Q2-Q1)'*n_2*a'/(n_2'*a))';
    C2 = -(Q1'- (Q1-Q2)'*n_1*b'/(n_1'*b))';

    k_p = cross(C1,k);

    delta = norm(k_p);
    
    plot(Time, delta, '-b.');
    hold on
    
    pause(dt)
    
    Time = Time + dt;
    
end








