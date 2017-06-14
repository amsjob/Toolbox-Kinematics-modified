classdef DualNumber
    %DualNumber - class for calculations with dual Numbers
    
    % o history
    %   Daniel Klawitter
    %   created 20-10-2009 - 20:00
    %
    % o summary
    %   dual numbers contain two real numbers, divided in real and dual
    %   part
    %   D = D + epsilon * D'
    %   methods for multiplication, addition and so on are implemented
    %
    % o TODO:
    %
    
    properties
        real
        dual
    end
    
    methods
        % constructor
        function obj = DualNumber(a,b)
            if nargin < 2
                obj.real = 0;
                obj.dual = 0;
            else
                obj.real = a;
                obj.dual = b;
            end
        end
        
        % overload the plus function '+'
        function obj = plus(a,b)
            obj = DualNumber;
            obj.real = a.real + b.real;
            obj.dual = a.dual + b.dual;
        end
        
        % overload the minus function '-'
        function obj = minus(a,b)
            obj = DualNumber;
            obj.real = a.real - b.real;
            obj.dual = a.dual - b.dual;
        end
        
        % overload the multiplication '*'
        function obj = mtimes(a,b)
            obj = DualNumber;
            obj.real = a.real * b.real;
            obj.dual = a.real*b.dual + a.dual*b.real;
        end
        
        % overload the multiplication with scalars '.*'
        % also treat the case if there are dual quaternions
        function obj = times(a,b)
            if isa(b,'Dualquaternion')
                obj = Dualquaternion;
                obj.realpart.scal = a.real*b.realpart.scal;
                obj.realpart.vect = a.real.*b.realpart.vect;
                obj.dualpart.scal = a.dual*b.realpart.scal;
                obj.dualpart.vect = a.dual.*b.realpart.vect;
            else
                obj = DualNumber;
                obj.real = a*b.real;
                obj.dual = a*b.dual;
            end
        end
        
        % overload the sqrt-function, for the norm of dual quaternions
        function obj = sqrt(a)
            obj = DualNumber;
            obj.real = sqrt(a.real);
            obj.dual = a.dual/(2*sqrt(a.real));
        end
        
        % gives the conjugated dual Number
        function obj = conjugate(a)
            obj = DualNumber;
            obj.real = a.real;
            obj.dual = -a.dual;
        end
        
        % gives the inverse  dual Number
        function obj = inv(a)
            obj = DualNumber;
            obj = (1/(a.real^2)).*conjugate(a);
        end
        
        function disp(obj)
            disp('class DualNumber');
            disp([num2str(obj.real),' + epsilon * ( ',num2str(obj.dual),' )']);
        end
        
    end
    
end

