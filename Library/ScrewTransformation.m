function obj = ScrewTransformation(k, p, theta, d)
    
    obj = Dualquaternion;

    % 'k' is direction vector
    % 'p' is the point in which the line intersect
    % 'theta' is the rotation about kHat [radians]

    
    
    q = DirVec2Quat(k, theta); %  q = [w x y z]
    
    P = Quaternion(0, transpose(p));
    
    kPrime = P*q;
    
    kMoment = times(0.5, kPrime); % Eq. 725
    
    kDir = q;
    
    kHat = Dualquaternion(kDir, kMoment);

    obj = kHat;
end