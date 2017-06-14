
function obj = matDualQuatMult(mat, DQ)

    obj = Dualquaternion;
    
    DQr = DQ.realpart;
    DQd = DQ.dualpart;

    [rows,cols] = size(mat);
        

    if rows == 8 && cols == 8
       M11 = mat(1:4, 1:4);
       M12 = mat(1:4, 5:8);
       M21 = mat(5:8, 1:4);
       M22 = mat(5:8, 5:8);
        
       obj.realpart = matQuatMult(M11, DQr)+matQuatMult(M12, DQd);

       obj.dualpart = matQuatMult(M21, DQr)+matQuatMult(M22, DQd);
       
    end

    
    
    
end % END FUNCTION

