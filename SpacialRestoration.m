function [EX, WY, Gray] = SpacialRestoration(x, y, xz, yz)
        % Using Spacial Transformation
        % For X
        syms K1 K2 K3 K4
        eqn1 = x*K1 + y*K2 + x*y*K3 + K4 == (xz);
        [a, b, c, d] = solve(eqn1, [K1, K2, K3, K4]);
        X = [a, b, c, d];
        
        % For Y
        syms K5 K6 K7 K8
        eqn2 = x*K5 + y*K6 + x*y*K7 + K8 == (yz);
        [e, f, g, h] = solve(eqn2, [K5, K6, K7, K8]);
        Y = [e, f, g, h];
        
        X_dash = uint8((x)*(X(1)) + (y)*(X(2)) + ((x)*(y))*(X(3)) + (X(4)));
        Y_dash = uint8((x)*(Y(1)) + (y)*(Y(2)) + ((x)*(y))*(Y(3)) + (Y(4)));
        
        % Gray level interpolation
        global originalimage;
        if(((rem(1, X_dash)==0) && (rem(1, Y_dash)==0)) && ((Y_dash >= 0) && (Y_dash >= 0)))
            X_dash = round(X_dash); Y_dash = round(Y_dash);
            syms A1 A2 A3 A4
            eq1 = ((X_dash)*(A1)) + ((Y_dash)*(A2)) + ((X_dash)*(Y_dash)*(A3)) + A4 == originalimage(X_dash+1, Y_dash);
            eq2 = ((X_dash)*(A1)) + ((Y_dash)*(A2)) + ((X_dash)*(Y_dash)*(A3)) + A4 == originalimage(X_dash-1, Y_dash);
            eq3 = ((X_dash)*(A1)) + ((Y_dash)*(A2)) + ((X_dash)*(Y_dash)*(A3)) + A4 == originalimage(X_dash, Y_dash+1);
            eq4 = ((X_dash)*(A1)) + ((Y_dash)*(A2)) + ((X_dash)*(Y_dash)*(A3)) + A4 == originalimage(X_dash, Y_dash-1);
            [j, k, l, m] = solve([eq1 eq2 eq3 eq4], [A1 A2 A3 A4]);
            Z = [j, k, l, m];
            
            Gray = uint8(floor(((X_dash)*(Z(1))) + ((Y_dash)*(Z(2))) + ((X_dash)*(Y_dash)*(Z(3))) + Z(4)));
        else
            Gray = uint8(round(originalimage(X_dash, Y_dash)));
        end
        
        EX=round(X_dash);
        WY=round(X_dash);
end