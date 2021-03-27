function  RGBResult = RGB(MyImageName,MaskSize,ConvMasks,OutputName)
%RGB uses the function parameters from My2dFilters to call the
%pixel window size and type of convolution masks. Uses this code on each of
%the colour channels which have already been split before hand. Then
%concatanates them into 'result'. Uses result to display filtered image. OutputName
%also called from My2dFilters which sets a parameter for imwrite to save file
%name to any user input.

I= (MyImageName);

%split the RGB colour channels up.
redchan = I(:,:,1);
greenchan = I(:,:,2);
bluechan = I(:,:,3);

%execute My2DFilters code on each of the colour channels individually, so each of the colour channels
%will have the kernel and pixelwindow vertically and horizantally go across the image.
r  = My2DFilters(redchan,MaskSize,ConvMasks,OutputName);
g  = My2DFilters(greenchan,MaskSize,ConvMasks,OutputName);
b  = My2DFilters(bluechan,MaskSize,ConvMasks,OutputName);

%concatenate the individual filtered channels back together.
result = cat(3,r,g,b);

%displays the original and filtered/edge detected image.
figure,
subplot(1,2,1),imshow(uint8(I), 'DisplayRange',[]), title 'Original Image';
subplot(1,2,2),imshow(uint8(result), 'DisplayRange',[]), title 'Filtered Image';

%Saves Image with user entered name.
imwrite (uint8(result),OutputName);

end

    
