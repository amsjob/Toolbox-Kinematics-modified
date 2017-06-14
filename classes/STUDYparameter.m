classdef STUDYparameter
    %STUDYparameter
    %
    % o history
    %   Daniel Klawitter
    %   created 26-10-2009 - 12:58
    %
    % o summary
    %   class for study parameters
    %
    %
    % o TODO:
    %
    
    properties
        parameters
        dualQuaternion
    end
    
    methods
        function obj = STUDYparameter(varargin)
            if nargin < 1
                % identity
                obj.parameters    = zeros(8,1);
                obj.parameters(1) = 1;
                obj.dualQuaternion = Dualquaternion(Quaternion(1,[0 0 0]),Quaternion);
            else
                %
                obj.parameters    = zeros(8,1);
                obj.parameters    = varargin{1}';
                a = obj.parameters(1:4);
                b = obj.parameters(5:8);
                obj.dualQuaternion = Dualquaternion(Quaternion(a(1),[a(2) a(3) a(4)]),...
                    Quaternion(b(1),[b(2) b(3) b(4)]));
            end
        end
        
        % creates a homogeneous rotation matrix out of study parameters
        function obj = getHomogeneousMatrix(study)
            %             a = study.parameters;
            rotation = study.dualQuaternion.getRotation;
            rotation = HomogeneousVector([rotation.realpart.scal, rotation.realpart.vect]);
            translation = study.dualQuaternion.getTranslation;
            translation = HomogeneousVector([ 1 , translation.dualpart.vect]);
            
            obj = HomogeneousTransformationMatrix(translation,rotation);
            
        end
        
        % convert from object to a double vector containing study
        % parameters
        function res = double(obj)
            res = double(obj.parameters);
        end
        
        function disp(obj)
            disp('class STUDYparameter') ;
            disp(obj.parameters);
        end
    end
    
end

