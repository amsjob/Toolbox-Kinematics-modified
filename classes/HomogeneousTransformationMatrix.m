classdef HomogeneousTransformationMatrix
    %    HomogeneousTransformationMatrix - class for creation of
    %    homogeneous transformation matrices
    %
    %
    % o history
    %   Daniel Klawitter
    %   created 21-10-2009 - 14:06
    %
    %          /   1    |    0    0    0  \
    %         | -------------------------  |
    %     M = |   t1    |                  |
    %         |   t2    |        A         |
    %          \  t3    |                 /
    %
    %   where t is the translation part and A a rotation Matrix out of
    %   Euler coordinates
    
    % o summary
    %   class to generate matrix and perform some operations on it
    %
    % o Jüttler - Visualisation of moving objects
    %
    % o TODO:
    %
    
    properties
        data
        % the following properties are just for use to create dual
        % quaternions and so on
        rotation
        translation
    end
    
    methods
        % constructor
        % rotation and translation are HomogeneousVector objects, to be
        % sure, that the dual quaternions that will be generated are normed
        % on the correct way
        function obj = HomogeneousTransformationMatrix(varargin)
            if nargin == 0
                obj.data = eye(4);
            elseif nargin == 1
                % input is a HomogeneousMatrix, for clone the obj
                obj.data = varargin{1}.data;
            else
                translation = varargin{1}; %#ok<PROP>
                rotation = varargin{2}; %#ok<*PROP>
                obj = HomogeneousTransformationMatrix;
                if sqrt(sum(rotation.^2)) ~= 1
                    rotation = (1/sqrt(sum(rotation.^2))).*rotation;
                end
                A = RotationMatrix('EULER',double(rotation));
                obj.data(2:end,2:end) = A.data;
                obj.data(:,1)         = double(normalize(translation));
                obj.rotation = rotation;
                obj.translation = translation;
            end
        end
        
        % overload the '.*' operation
        function obj = times(a,b)
            obj = HomogeneousTransformationMatrix(b);
            obj.data = a.*obj.data;
        end
        
        %         function obj = normalize(a)
        %             obj = HomogeneousTransformationMatrix(a);
        %             if obj.data(1,1)~=1
        %                obj.data = 1/obj.data(1,1).*obj.data;
        %             end
        %         end
        
        % Homogeneous matrix * homogeneous vector behaves like rotation
        % followed by translation
        function obj = mtimes(a,b)
            if isa(a,'HomogeneousTransformationMatrix')&&isa(b,'HomogeneousTransformationMatrix')
                % a and b are HomogeneousTransformationMatrix
                obj = HomogeneousTransformationMatrix;
                obj.data = a.data * b.data;
            elseif isa(b,'HomogeneousVector')
                obj = HomogeneousVector((a.data*double(b)'));
                obj = normalize(obj);
            end
        end
        
        function disp(obj)
            disp('class HomogeneousTransformationMatrix');
            disp(obj.data);
        end
    end
    
end

