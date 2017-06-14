function obj = DirVec2Quat(k, theta)
    
    obj = Quaternion;

    % 'k' is direction vector
    % 'theta' is the rotation about 'k' [radians]

    k = k/norm(k);
    
    q = Quaternion(cos(theta/2), [k(1)*sin(theta/2) k(2)*sin(theta/2) k(3)*sin(theta/2)])
    
    obj = q;
end