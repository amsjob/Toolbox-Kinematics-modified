function obj = QuatCross(a, b)
    
    obj = Quaternion;
    
    %obj = Quaternion(0, b.scal*a.vect + a.scal*b.vect + cross(a.vect, b.vect))
    obj = times(0.5,a*b - conjugate(b)*conjugate(a));

    % NOTE: Either is fine, but the lower one is more elegant in my opinion
end