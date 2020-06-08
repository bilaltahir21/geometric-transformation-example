function [x,y] = FindGrayLevel( grayLevel )
    global ifReturned;
    global originalimage;
    
    x = -1; y = -1;
    
    [horizontal,vertical] = size(originalimage);
    for i=1 : horizontal
        for j=1 : vertical
            if(originalimage(i,j) == grayLevel && ifReturned(i,j) == 0)
                x=i; y=j;
                ifReturned(i,j) = 1;
                return;
            end
        end
    end
end