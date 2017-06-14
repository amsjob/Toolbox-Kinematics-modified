function obj = DQ2AffineMat(qeHat)

    errorReal = qeHat.realpart; % Sec. E
    errorDual = qeHat.dualpart; 
    t_e = 2.*conjugate(errorReal)*errorDual
    
    xPos = t_e.vect(1);
    yPos = t_e.vect(2);
    zPos = t_e.vect(3);
 
    t = [xPos yPos zPos];
    
    rot_e = [errorReal.scal errorReal.vect(1) errorReal.vect(2) errorReal.vect(3)];
    R = quat2rotm(rot_e);
    
    
    H = eye(4);
    
    H(1:3, 1:3) = R;
    H(1:3, 4) = t';
    
    H;
    
    frameI = plot3([0 1],[0 0],[0 0],'r',[0 0],[0 1],[0 0],'g',[0 0],[0 0],[0 1],'b','linewidth',2);
    hold on
    frameB = plot3([t(1) t(1)+R(1,1)],[t(2) t(2)+R(2,1)],[t(3) t(3)+R(3,1)],'r',[t(1) t(1)+R(1,2)],[t(2) t(2)+R(2,2)],[t(3) t(3)+R(3,2)],'g',[t(1) t(1)+R(1,3)],[t(2) t(2)+R(2,3)],[t(3) t(3)+R(3,3)],'b','linewidth',2);
    xlim([-.8 3]);
    ylim([-.8 3]);
    zlim([-.8 3]);
    hold off
    
    
    
end % END FUNCTION