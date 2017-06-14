function S = skew(s)

% returns a skew-symmetric 3x3 matrix

  if 3 ~= size(s,1),
    error('vector must be 3x1')
  end

S = [   0   -s(3)   s(2);
      s(3)   0     -s(1);
     -s(2)   s(1)     0 ];