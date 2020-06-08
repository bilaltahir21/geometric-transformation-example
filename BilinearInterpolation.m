function [x, y] = BilinearInterpolation( forX, forY, xCoordinate, yCoordinate)
    first = (xCoordinate)*(forX(1)) + (yCoordinate)*(forX(2)) + ((xCoordinate)*(yCoordinate))*(forX(3)) + (forX(4));
    second = (xCoordinate)*(forY(1)) + (yCoordinate)*(forY(2)) + ((xCoordinate)*(yCoordinate))*(forY(3)) + (forY(4));
    
    x=1;
    y=1;
    
    if(((first>0) && (second>0)))
        x=round(first);
        y=round(second);
    end
    
   % if(((rem(1,first)==0) && (rem(1,second)==0)) && ((first>=0) && (second>=0)))
   %     % Applying Gray-level interpolation
   %    
   %     x=first;
   %     y=second;
   % end
end

                % if((~isempty(X1) && ~isempty(X2) && ~isempty(X3) && ~isempty(X4)) ...
                % && (~isempty(Y1) && ~isempty(Y2) && ~isempty(Y3) && ~isempty(Y4)))
                