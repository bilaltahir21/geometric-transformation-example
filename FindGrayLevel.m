function [x,y] = FindGrayLevel( grayLevel )
    global geometrictransformed;
    [horizontal,vertical] = size(geometrictransformed);
    for i=1 : horizontal
        for j=1 : vertical
            if(geometrictransformed(i,j) == grayLevel)
                x=i;
                y=j;
                return;
            end
        end
    end
    x=-1;
    y=-1;
end