function obj = QuatDotProduct(a, b)

    obj = Quaternion;
    
    obj = Quaternion(a.scal*b.scal + dot(a.vect, b.vect) ,[0 0 0]);
    
end % END FUNCTION