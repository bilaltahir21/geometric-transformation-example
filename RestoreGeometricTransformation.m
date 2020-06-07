function RestoreGeometricTransformation()
    global originalimage;
    [horizontal,vertical] = size(originalimage);

    for i=2 : horizontal
        for j=2 : vertical
            % Finding these tie points
            first=originalimage(i-1,j-1);   % upper left
            second=originalimage(i-1,j+1);  % upper right
            third=originalimage(i+1,j-1);   % lower left
            fourth=originalimage(i+1,j+1);  % lower right

            [x1,y1] = FindGrayLevel(first);
            [x2,y2] = FindGrayLevel(second);
            [x3,y3] = FindGrayLevel(third);
            [x4,y4] = FindGrayLevel(fourth);

            if( x1~=-1 && x2~=-1 && x3~=-1 && x4~=-1 && ...
                y1~=-1 && y2~=-1 && y3~=-1 && y4~=-1 )
            
                % For x-component
                A = [ (x1) (y1) ((x1)*(y1)) (1); ...
                      (x2) (y2) ((x2)*(y2)) (1); ...
                      (x3) (y3) ((x3)*(y3)) (1); ...
                      (x4) (y4) ((x4)*(y4)) (1) ];
                B = [ (i-1) (i-1) (i+1) (i+1) ];
                % Gaussian Elimination
                X=B/A; % [ K1 K2 K3 K4 ]
                disp(X);
                
                % For y-component
                C = [ (x1) (y1) ((x1)*(y1)) (1); ...
                      (x2) (y2) ((x2)*(y2)) (1); ...
                      (x3) (y3) ((x3)*(y3)) (1); ...
                      (x4) (y4) ((x4)*(y4)) (1) ];
                D = [ (j-1) (j+1) (j-1) (j+1) ];
                % Gaussian Elimination
                Y=D/C; % [ K5 K6 K7 K8 ]
                disp(Y);
                
            end
        end
    end
end

