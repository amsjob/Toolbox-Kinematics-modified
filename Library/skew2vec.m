function obj = skew2vec(mat)

    %kx = [0 -k(3) k(2) ; k(3) 0 -k(1) ; -k(2) k(1) 0]
   
    k = [mat(3,2); mat(1,3) ;mat(2,1)];
    
    obj = k;

end