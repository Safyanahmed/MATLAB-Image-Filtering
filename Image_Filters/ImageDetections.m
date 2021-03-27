function MyDetectedImage = ImageDetections(MyImageName,MaskSize,ConvMasks,OutputName)
%IMAGEDETECTIONS uses the function parameters from My2dFilters to call the
%pixel window size and type of convolution masks. Uses the parameters from RGB and
%Greyscale to call outputName for the save file function. Finally uses
%MyImageName to read in the input image. 

%creates new output image.
I2 =imread(MyImageName);

%takes all convmasks turns them into strings then converts the strings
%into arrays so each one can be applied. 
%strtrim removes the white spaces from the ends of the the string 
%so no error is given if white space are left by accident. 
%split splits the the string at white spaces and returns the result as an
%output array.
ConvMasks = strtrim(ConvMasks);
ConvMasks = split(ConvMasks);
ConvMasks = ConvMasks';

%If dimensions of image equal to 3 execute RGB script for RGB images
%Otherwise ecxecute the greyscale script for greyscale images. 
if (ndims(I2) == 3)    
    RGB(I2,MaskSize,ConvMasks,OutputName);
else     
    Greyscale(I2,MaskSize,ConvMasks,OutputName); 
end
    
end
%example: ImageDetections('Tiger.jpg',3,'smoothing sobel','newimage.jpg')