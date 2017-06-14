classdef HomogeneousVector
    %    HomogeneousVector - class for calculations with Homogeneous
    %    Vectors
    %
    % o history
    %   Daniel Klawitter
    %   created 21-10-2009 - 12:27
    %
    % o summary
    %   functions to handle homogeneous vectors and export them to dual
    %   quaternions representing translations, rotations or spatial
    %   displacements
    %
    % o Jüttler - Visualisation of moving objects
    %
    % o TODO:
    %
    
    properties
        lambda % the homogeneous factor
        coords % the vector
    end
    
    methods
        % constructor
        function obj = HomogeneousVector(vect)
            
            if nargin == 0
                obj.lambda = 1;
                obj.coords = [0 0 0];
            else
                if size(vect,1)>1
                    vect = vect';
                end
                obj.lambda = vect(1);
                obj.coords = vect(2:end);
            end
        end
        
        % transform the homogeneous factor to 1
        function obj = normalize(a)
            obj = HomogeneousVector([1, 1/a.lambda.*a.coords ]);
        end
        
        % overwrite the '.*' operation
        function obj = times(a,b)
            obj = HomogeneousVector;
            obj.lambda = a*b.lambda;
            obj.coords = a.*b.coords;
        end
        
        % overload the '.^' operator
        function obj = power(b,a)
            obj = HomogeneousVector;
            obj.lambda = b.lambda.^a;
            obj.coords = b.coords.^a;
        end
        
        % overload the sum function for HomogeneousVector
        function res = sum(a)
            res = a.lambda + sum(a.coords);
        end
        
        % function that retunrs a dual quaternion
        % attention the homogeneous factor will be scaled to 2 so the
        % coords- property contains the real translation a vector
        function obj = dualTranslationQuaternion(a)
            if a.lambda ~=2
                a = 2.*normalize(a);
            end
            obj = Dualquaternion;
            obj.realpart.scal = a.lambda;
            obj.dualpart.vect = a.coords;
        end
        
        % function to generate a unit quaternion containing euler angles for
        % rotation purposes
        % attention the coordinates will be normed to 1
        function obj = rotationQuaternion(a)
            if sqrt(sum(a.^2)) ~= 1
                a = (1/sqrt(sum(a.^2))).*a;
            end
            obj = Quaternion;
            obj.scal = a.lambda;
            obj.vect = a.coords;
        end
        
        % function to generate a dual quaternion containing euler angles for
        % rotation purposes
        % attention the coordinates will be normed to 1
        function obj = dualRotationQuaternion(a)
            if sqrt(sum(a.^2)) ~= 1
                a = (1/sqrt(sum(a.^2))).*a;
            end
            obj = Dualquaternion;
            obj.realpart.scal = a.lambda;
            obj.realpart.vect = a.coords;
        end
        
        % the spatial displacement is defined through a translation and
        % after that a rotation (not the product does not commutate)
        % this dual quaternion satisfies Plücker's relation mentioned in
        % Jüttler - Visualisation of moving objects
        function obj = DualSpatialDisplacementQuaternion(translation,rotation)
            trans = dualTranslationQuaternion(translation);
            rotat = dualRotationQuaternion(rotation);
            obj = trans*rotat;
        end
        
        % convert a HomogeneousVector class object to a normal double
        % vector
        function res = double(obj)
            res(1)   = obj.lambda;
            res(2:4) = obj.coords;
        end
        
        function disp(obj)
            disp('class HomogeneousVector');
            disp(['[',num2str(obj.lambda),',',num2str(obj.coords(1)),',',num2str(obj.coords(2)),',',num2str(obj.coords(3)),']']);
        end
    end
    
end

