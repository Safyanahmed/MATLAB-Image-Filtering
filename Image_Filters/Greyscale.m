function MyFilteredGreyscaleImage  = Greyscale (ImageData,MaskSize,ConvMasks,OutputName)
%GREYSCALE uses the function parameters from My2dFilters to call the
%pixel window size and type of convolution masks. Writes them into a
%variable 'result' which is used to display the filtered image. OutputName
%also called from My2dFilters which sets a parameter for imwrite to save file
%name to any user input.

I = ImageData;

%passes in parameters from My2dFilters.  
result = My2DFilters(ImageData,MaskSize,ConvMasks);

%displays the original and filtered/edge detected image.
figure,subplot(1,2,1), imshow(uint8(I), 'DisplayRange',[]), title 'Original Image';
subplot(1,2,2), imshow(uint8(result), 'DisplayRange',[]), title 'Filtered Image';

%Saves Image with user entered name.
imwrite (uint8(result),OutputName);
end



