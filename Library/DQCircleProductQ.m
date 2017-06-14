% Returns a quaternion

function obj = DQCircleProduct(aHat, bHat)

    obj = Quaternion;
    
    obj = QuatDotProduct(aHat.realpart, bHat.realpart) + QuatDotProduct(aHat.dualpart, bHat.dualpart);

    %obj = Dualquaternion(QuatDotProduct(aHat.realpart, bHat.realpart), QuatDotProduct(aHat.dualpart, bHat.dualpart))
    
end % END FUNCTION

