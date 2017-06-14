% Defined as:
% aHat ¤ bHat = ar ¤ br + eps*(ad ¤ br + ar ¤ bd)


function obj = DQDotProduct(aHat, bHat)
    
    obj = Dualquaternion;
   
    objReal = QuatDotProduct(aHat.realpart, bHat.realpart);
    objDual = QuatDotProduct(aHat.dualpart, bHat.realpart)+QuatDotProduct(aHat.realpart, bHat.dualpart);
  
    obj = Dualquaternion(objReal,objDual);
    
end % END FUNCTION