function obj = DQVec(aHat)
    
    obj = Dualquaternion;
    
    ar = aHat.realpart;
    ad = aHat.dualpart;
    
    obj = Dualquaternion(Quaternion(0, ar.vect), Quaternion(0, ad.vect));

end