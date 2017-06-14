function obj = DQCross(a, b)
    
    obj = Dualquaternion;
    
    objReal = QuatCross(a.realpart, b.realpart);
    
    objDual = QuatCross(a.dualpart, b.realpart) + QuatCross(a.realpart, b.dualpart);
    
    obj = Dualquaternion(objReal, objDual);
    
    % obj = Quaternion(0, b.scal*a.vect + a.scal*b.vect + cross(a.vect, b.vect))

end