% Returns a DQ

function obj = DQCircleProduct2(aHat, bHat)

    obj = Quaternion;
    
    objReal = QuatDotProduct(aHat.realpart, bHat.realpart) + QuatDotProduct(aHat.dualpart, bHat.dualpart);
    
    objDual = Quaternion(0, [0 0 0]);
    
    obj = Dualquaternion(objReal, objDual);
    %obj = Dualquaternion(QuatDotProduct(aHat.realpart, bHat.realpart), QuatDotProduct(aHat.dualpart, bHat.dualpart))
    
end % END FUNCTION

