classdef Dualquaternion
    %Dualquaternion - class for calculations with dual quaternions
    
    % o history
    %   Daniel Klawitter
    %   created 20-10-2009 - 17:00
    %
    % o summary
    %   a dual quaternion or biquaternion contains two objects of
    %   quaternion class (see Quaternion.m)
    %   Q_d = Q + epsilon * Q
    %   methods for multiplication, addition and so on are implemented
    %
    %   dual quaternions can represent spatial displacements
    %   functions for
    %       o dual translation quaternion creation
    %       o dual rotation quaternion creation
    %       o dual spatial displacement quaternion creation
    %   are implemented in class HomogeneousVector
    %
    % o TODO:
    %
    
    properties
        realpart % this property is a quaternion, so it also have subproperties scal and vect
        dualpart % this property is a quaternion, so it also have subproperties scal and vect
    end
    
    methods
        % constructor with no input or two quaternions
        function obj = Dualquaternion(q1,q2)
            if nargin == 0
                obj.realpart = Quaternion;
                obj.dualpart = Quaternion;
            else
                obj.realpart = q1;
                obj.dualpart = q2;
            end
        end
        
        % overload of the plus operation '+'
        function obj = plus(a,b)
            obj = Dualquaternion;
            obj.realpart = a.realpart + b.realpart;
            obj.dualpart = a.dualpart + b.dualpart;
        end
        
        % overload of the minus operation '-'
        function obj = minus(a,b)
            obj = Dualquaternion;
            obj.realpart = a.realpart - b.realpart;
            obj.dualpart = a.dualpart - b.dualpart;
        end
        
        % overload of the multiplication sign '*'
        % succesfully tested
        function obj = mtimes(a,b)
            obj = Dualquaternion;
            obj.realpart.scal = a.realpart.scal * b.realpart.scal - (a.realpart.vect * b.realpart.vect');
            obj.dualpart.scal = a.realpart.scal * b.dualpart.scal + a.dualpart.scal * b.realpart.scal...
                -(a.dualpart.vect*b.realpart.vect' + a.realpart.vect*b.dualpart.vect');
            obj.realpart.vect =   a.realpart.scal.*b.realpart.vect + ...
                b.realpart.scal.*a.realpart.vect +...
                cross(a.realpart.vect,b.realpart.vect);
            obj.dualpart.vect = a.realpart.scal .* b.dualpart.vect + a.dualpart.scal.*b.realpart.vect +...
                b.realpart.scal.*a.dualpart.vect + b.dualpart.scal.*a.realpart.vect +...
                cross(a.dualpart.vect,b.realpart.vect)+cross(a.realpart.vect,b.dualpart.vect);
        end
        
        % overload of the multiplication with scalars '.*'
        function obj = times(a,b)
            % multiply with a dual scalar
            if isa(a,'DualNumber')
                obj = Dualquaternion;
                obj.realpart.scal = a.real*b.realpart.scal;
                obj.realpart.vect = a.real.*b.realpart.vect;
                obj.dualpart.scal = a.dual*b.realpart.scal;
                obj.dualpart.vect = a.dual.*b.realpart.vect;
                % multiply with a real scalar
            else
                obj = Dualquaternion;
                obj.realpart = a.*b.realpart;
                obj.dualpart = a.*b.dualpart;
            end
        end
        
        % calculate the conjugated quaternion
        function obj = conjugate(a)
            obj = Dualquaternion;
            obj.realpart.scal = a.realpart.scal;
            obj.dualpart.scal = a.dualpart.scal;
            obj.realpart.vect = -a.realpart.vect;
            obj.dualpart.vect = -a.dualpart.vect;
        end
        
        % calculate the dual conjugated quaternion
        function obj = dualconjugate(a)
            obj = Dualquaternion;
            obj.realpart.scal = a.realpart.scal;
            obj.dualpart.scal = -a.dualpart.scal;
            obj.realpart.vect = a.realpart.vect;
            obj.dualpart.vect = -a.dualpart.vect;
        end
        
        % note that this norm does not define a norm on H_d
        function obj = norm(a)
            obj = Dualquaternion;
            obj = a*conjugate(a);
            % the norm to the power of 2 is a dual number (look class DualNumber)
            obj = DualNumber(obj.realpart.scal,a.dualpart.scal);
            % uses the sqrt-function of the class DualNumber
            obj = sqrt(obj);
        end
        
        % returns the translationla part of a dual quaternion that
        % represents a spatial displacement
        % returns dual quaternion
        function obj = getTranslation(a)
            obj = a*Dualquaternion(conjugate(a.realpart),Quaternion);
            obj = 1/(obj.realpart.scal/2).*obj;
        end
        
        % returns dual quaternion that represents a pure rotation
        function obj = getRotation(a)
            % these two operations are on Quaternions
            % for formula see Jüttler - Visualization of moving onjects
            obj = inv(a.realpart*conjugate(a.realpart)) * a.realpart;
            
            % transform to dual Quaternion
            obj = Dualquaternion(obj,Quaternion);
        end
        
        % default: depends on the dual quaternion
        function obj = displace(Q,x)
            obj = Q*x*dualconjugate(conjugate(Q));
            %             obj = normalize(obj);
        end
        
        % function that calculates the spatial displacement
        % if user wants to take influence on the order of the seperate
        % operations
        % first rotate the translate
        function obj = displaceRT(Q,x)
            T = getTranslation(Q);
            R = getRotation(Q);
            obj = R*x*dualconjugate(conjugate(R));
            obj = T*obj*dualconjugate(conjugate(T));
            %             obj = normalize(obj);
        end
        
        % first tranlate teh rotate
        function obj = displaceTR(Q,x)
            T = getTranslation(Q);
            R = getRotation(Q);
            obj = T*x*dualconjugate(conjugate(T));
            obj = R*obj*dualconjugate(conjugate(R));
            %             obj = normalize(obj);
        end
        
        function study = getStudyParameters(obj)
            study(1)  = obj.realpart.scal;
            study(2:4)= obj.realpart.vect;
            study(5)  = obj.dualpart.scal;
            study(6:8)= obj.dualpart.vect;
            study = STUDYparameter(study);
            
        end
        
        % function to bring the realpart.scal property to the value 1
        function obj = normalize(a)
            obj = (1/sqrt(a.realpart.scal^2 + sum(a.realpart.vect.^2) ) ).*a;
        end
        
        function disp(obj)
            disp('class Dualquaternion');
            disp([num2str(obj.realpart.scal),'+ ',num2str(obj.realpart.vect(1)),'i+ ',num2str(obj.realpart.vect(2)),'j+ ',num2str(obj.realpart.vect(3)),'k+ epsilon*(',...
                num2str(obj.dualpart.scal),'+ ',num2str(obj.dualpart.vect(1)),'i+ ',num2str(obj.dualpart.vect(2)),'j+ ',num2str(obj.dualpart.vect(3)),'k)'])
        end
        
        function erg = latex1(a)
            erg=[num2str(a.realpart.scal),'+',num2str(a.dualpart.scal),'\epsilon+(',num2str(a.realpart.vect(1)),'+',num2str(a.dualpart.vect(1)),'\epsilon)\mathbf{i}',...
                '+(',num2str(a.realpart.vect(2)),'+',num2str(a.dualpart.vect(2)),'\epsilon)\mathbf{j}','+(',num2str(a.realpart.vect(3)),'+',num2str(a.dualpart.vect(3)),'\epsilon)\mathbf{k}'];
        end
        
        function erg = latex2(a)
            erg=[num2str(a.realpart.scal),'+',num2str(a.realpart.vect(1)),'\mathbf{i}+',num2str(a.realpart.vect(2)),'\mathbf{j}+',num2str(a.realpart.vect(3)),'\mathbf{k}',...
                '+(',num2str(a.dualpart.scal),'+',num2str(a.dualpart.vect(1)),'\mathbf{i}+',num2str(a.dualpart.vect(2)),'\mathbf{j}+',num2str(a.dualpart.vect(3)),'\mathbf{k})\epsilon',];
        end
    end
    
end

