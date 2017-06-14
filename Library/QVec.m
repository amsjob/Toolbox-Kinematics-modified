function obj = QVec(aHat)
    
    obj = Quaternion;
    
    obj = Quaternion(0, aHat.vect);
    
end