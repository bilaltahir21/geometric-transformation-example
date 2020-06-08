function RestoreGeometricTransformation()
    global originalimage;
    [horizontal,vertical] = size(originalimage);
    
    global geometrictransformed;
    proxyImage = uint8(zeros(horizontal, vertical));
    
    i=1;
    j=1;
    
    while i+1 < horizontal
        while j+1 < vertical
            % Finding these tie points
            first = originalimage(i,j);   % upper left
            second = originalimage(i,j+1);  % upper right
            third = originalimage(i+1,j);   % lower left
            fourth = originalimage(i+1,j+1);  % lower right

            [x1,y1] = FindGrayLevel(first);
            [x2,y2] = FindGrayLevel(second);
            [x3,y3] = FindGrayLevel(third);
            [x4,y4] = FindGrayLevel(fourth);

             if( x1~=-1 && x2~=-1 && x3~=-1 && x4~=-1 && ...
                y1~=-1 && y2~=-1 && y3~=-1 && y4~=-1 )            
                % For x-component
                syms a1 b1 c1 d1 e1 f1 g1 h1 i1 j1 k1 l1 m1 n1 o1 p1
                eqn1 = x1*a1 + y1*b1 + x1*y1*c1 + d1 == (i);
                [a, b, c, d] = solve(eqn1, [a1, b1, c1, d1]);
                X1 = [a, b, c, d];
                
                eqn2 = x2*e1 + y2*f1 + x2*y2*g1 + h1 == (i);
                [a, b, c, d] = solve(eqn2, [e1, f1, g1, h1]);
                X2 = [a, b, c, d];
                
                eqn3 = x3*i1 + y3*j1 + x3*y3*k1 + l1 == (i+1);
                [a, b, c, d] = solve(eqn3, [i1, j1, k1, l1]);
                X3 = [a, b, c, d];
                
                eqn4 = x4*m1 + y4*n1 + x4*y4*o1 + p1 == (i+1);
                [a, b, c, d] = solve(eqn4, [m1, n1, o1, p1]);
                X4 = [a, b, c, d];
                
                % For y-component
                syms a2 b2 c2 d2 e2 f2 g2 h2 i2 j2 k2 l2 m2 n2 o2 p2
                eqn1 = x1*a2 + y1*b2 + x1*y1*c2 + d2 == (j);
                [e, f, g, h] = solve(eqn1, [a2, b2, c2, d2]);
                Y1 = [e, f, g, h];
                
                eqn2 = x2*e2 + y2*f2 + x2*y2*g2 + h2 == (j+1);
                [e, f, g, h] = solve(eqn2, [e2, f2, g2, h2]);
                Y2 = [e, f, g, h];
                
                eqn3 = x3*i2 + y3*j2 + x3*y3*k2 + l2 == (j);
                [e, f, g, h] = solve(eqn3, [i2, j2, k2, l2]);
                Y3 = [e, f, g, h];
                
                eqn4 = x4*m2 + y4*n2 + x4*y4*o2 + p2 == (j+1);
                [e, f, g, h] = solve(eqn4, [m2, n2, o2, p2]);
                Y4 = [e, f, g, h];
                
                % Reverse Mapping
                % Upper left
                one1 = uint8((x1)*(X1(1)) + (y1)*(X1(2)) + ((x1)*(y1))*(X1(3)) + (X1(4)));
                two1 = uint8((x1)*(Y1(1)) + (y1)*(Y1(2)) + ((x1)*(y1))*(Y1(3)) + (Y1(4)));
                % Upper right
                one2 = uint8((x2)*(X2(1)) + (y2)*(X2(2)) + ((x2)*(y2))*(X2(3)) + (X2(4)));
                two2 = uint8((x2)*(Y2(1)) + (y2)*(Y2(2)) + ((x2)*(y2))*(Y2(3)) + (Y2(4)));
                % Lower left
                one3 = uint8((x3)*(X3(1)) + (y3)*(X3(2)) + ((x3)*(y3))*(X3(3)) + (X3(4)));
                two3 = uint8((x3)*(Y3(1)) + (y3)*(Y3(2)) + ((x3)*(y3))*(Y3(3)) + (Y3(4)));
                % Lower right
                one4 = uint8((x4)*(X4(1)) + (y4)*(X4(2)) + ((x4)*(y4))*(X4(3)) + (X4(4)));
                two4 = uint8((x4)*(Y4(1)) + (y4)*(Y4(2)) + ((x4)*(y4))*(Y4(3)) + (Y4(4)));
                    
                if((one1 > 0 && one1 < horizontal) && (one2 > 0 && one2 < horizontal) && (one3 > 0 && one3 < horizontal) && (one4 > 0 && one4 < horizontal) ...
                && (two1 > 0 && two1 < vertical) && (two2 > 0 && two2 < vertical) && (two3 > 0 && two3 < vertical) && (two4 > 0 && two4 < vertical))
                    proxyImage(one1,two1) = geometrictransformed(x1, y1);
                    proxyImage(one2,two2) = geometrictransformed(x2, y2);
                    proxyImage(one3,two3) = geometrictransformed(x3, y3);
                    proxyImage(one4,two4) = geometrictransformed(x4, y4);
                end
            end
            j=j+2;
        end
        i=i+2;
    end
    global restoredimage;
    restoredimage = proxyImage;
end

