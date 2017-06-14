function obj = vec2skew(vec)

    k = vec;

    kx = [0 -k(3) k(2) ; k(3) 0 -k(1) ; -k(2) k(1) 0]

    obj = kx;

end