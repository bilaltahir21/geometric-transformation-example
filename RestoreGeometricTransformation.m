function RestoreGeometricTransformation()
    global originalimage;
    [horizontal,vertical] = size(originalimage);
    
    global geometrictransformed;
    proxyImage = uint8(ones(horizontal, vertical));
    
    for i=1:horizontal
        for j=1:vertical
            proxyImage(i,j) = 100;
        end
    end
    
    global ifReturned;
    ifReturned=uint8(zeros(horizontal, vertical));
    
    i=2;
    while i < horizontal - 2
        j = 2;
        while j < vertical - 2
            i_ul = i; j_ul = j;     % upper left
            i_ur = i; j_ur = j+1;   % upper right
            i_ll = i+1; j_ll = j;   % lower left
            i_lr = i+1; j_lr = j+1; % lower right
            
            % Finding these tie points
            first = geometrictransformed(i_ul, j_ul);   % upper left
            second = geometrictransformed(i_ur, j_ur);  % upper right
            third = geometrictransformed(i_ll, j_ll);   % lower left
            fourth = geometrictransformed(i_lr, j_lr);  % lower right
            
            [x1,y1] = FindGrayLevel(first);
            [x2,y2] = FindGrayLevel(second);
            [x3,y3] = FindGrayLevel(third);
            [x4,y4] = FindGrayLevel(fourth);
            
            if((x1 > 1 && x1 < horizontal) && (x2 > 1 && x2 < horizontal) && (x3 > 1 && x3 < horizontal) && (x4 > 1 && x4 < horizontal) ...
                    && (y1 > 1 && y1 < vertical) && (y2 > 1 && y2 < vertical) && (y3 > 1 && y3 < vertical) && (y4 > 1 && y4 < vertical))
                [A1, B1, C1] = SpacialRestoration(i_ul, j_ul, x1, y1);
                proxyImage(round(A1), round(B1)) = C1;
                [A2, B2, C2] = SpacialRestoration(i_ur, j_ur, x2, y2);
                proxyImage(round(A2), round(B2)) = C2;
                [A3, B3, C3] = SpacialRestoration(i_ll, j_ll, x3, y3);
                proxyImage(round(A3), round(B3)) = C3;
                [A4, B4, C4] = SpacialRestoration(i_ll, j_ll, x3, y3);
                proxyImage(round(A4), round(B4)) = C4;
            end
            j=j+2;
        end
        i=i+2;
        % imshow(proxyImage);
    end
    global restoredimage;
    restoredimage = proxyImage;
    % figure, imshow(proxyImage);
end

