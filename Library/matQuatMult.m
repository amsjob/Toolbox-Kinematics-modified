% Note that quaternions in Tsiotras are written as:
% q = (qVec, qScal)
% This has been handled here
function obj = matQuatMult(mat, quat)

    obj = Quaternion; 

    [rows,cols] = size(mat);

    if rows == 4 && cols == 4
       M11 = mat(1:3, 1:3); % 3 by 3
       M12 = mat(1:3, 4);   % 3 by 1
       M21 = mat(4, 1:3);   % 1 by 3
       M22 = mat(4,4);      % 1 by 1 / R

       qVect1 = M11 * transpose(quat.vect);
       qVect2 = M12 * quat.scal;

       qScal1 = M21 * transpose(quat.vect);
       qScal2 = M22 * quat.scal;

       obj.scal = qScal1+qScal2;
       obj.vect = transpose(qVect1+qVect2);
    end

end % END FUNCTION

