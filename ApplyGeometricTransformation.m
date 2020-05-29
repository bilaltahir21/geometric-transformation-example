function ApplyGeometricTransformation()
    global geometrictransformed;
    global originalimage;
    transform = affine2d([1 0 0; .5 1 0; 0 0 1]);
    geometrictransformed = imwarp(originalimage,transform);
end
