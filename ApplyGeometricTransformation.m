function ApplyGeometricTransformation( transf )
    global geometrictransformed;
    global originalimage;
    
    input = originalimage;
    % BILINEAR_INTERPOLATION generates the transformed image based on
    % input image and transform matrix using bilinear interpolation.
    [horizontal, vertical] = size(input);
    output = zeros(horizontal, vertical);
    for i = 1:horizontal
        for j = 1:vertical
            % Mapping grey levels by using Gaussian Elimination ('A/B' means AX=B)
            inverse_pos = round([i-horizontal/2 j-vertical/2 1] / transf + [horizontal/2 vertical/2 0]);
            x = inverse_pos(1);
            y = inverse_pos(2);
            
            disp(inverse_pos);
            
            if x >= 1 && x <= horizontal && y >= 1 && y <= vertical
                x1 = x - floor(x);
                y1 = y - floor(y);
                output(i, j) = input(floor(x), floor(y)) * (1 - x1) * (1 - y1) + ...
                               input(floor(x), ceil(y)) * (1 - x1) * y1 + ...
                               input(ceil(x), floor(y)) * x1 * (1 - y1) + ...
                               input(ceil(x), ceil(y)) * x1 * y1;
            end
        end
    end
    
    geometrictransformed=output;
end