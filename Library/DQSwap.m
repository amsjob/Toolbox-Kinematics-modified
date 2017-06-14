% aHat = a + eps*a_p
% -> aHat = a_p + eps*a
function obj = DQSwap(aHat)

    obj = Dualquaternion;
    
    obj = Dualquaternion(aHat.dualpart, aHat.realpart);
    
    
    
end % END FUNCTION

