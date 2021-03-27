function MyFilteredImage  = My2DFilters(ImageData,MaskSize,ConvMasks,OutputName)
%MY2DFILTERS creates pixel window size and convolution masks switch
%statement which is house inside three for loops. The biggest one checks for
%convolution parameters inside the command window and executes them one
%after the other. The two nested inside takes the kernel across the
%image. Before this the image is padded using 'impad' function that
%creaates a 0 sum border around the image.

I = ImageData;

%Pad the image across X and Y positions
imPad = floor(MaskSize/2);
I = double(padarray(I,[imPad imPad],'replicate'));
[ySize, xSize]=size(I);
I2 = zeros(ySize,xSize);

%Gets first mask from entered parameter, applies it, then rechecks if there
%is a second mask parameter, if there is apply that to the result. Rinse and repeat. 
%Loops the PixelWindow, Filters and Edge Detections across the image vertically
%and horrizantally.  
for ConvMask = ConvMasks
    ConvSwitch = char(ConvMask);
    for i=imPad+1:ySize-imPad
        for j=imPad+1:xSize-imPad
            pixelWindow = I(i-imPad:i+imPad, j-imPad:j+imPad);
            
%Switch statement used to execute one of several lines of code depending on a string name. 
%Inside each case a either a 3x3 or 5x5 kernel with it's convolution code.            
            switch ConvSwitch
                %Linear
                case 'unsharp'
                    if (MaskSize == 3)
                        filter = [-0.1667,-0.0667,0.1667;-0.6667,4.3333,0.6667;-0.166,-0.6667,-0.1667];
                        c= pixelWindow.*filter;
                        I2(i,j) = sum(sum(c));
                    else 
                        A = [-0.1667,-0.0667,0.1667,0.1667,0.1667;-0.6667,4.3333,0.6667,4.3333,0.6667;-0.166,-0.6667,-0.1667,-0.166,-0.1667;4.3333,-0.6667,4.3333,-0.6667,4.3333;0.1667,-0.166,0.1667,-0.166,0.1667];
                        D = pixelWindow;
                        E = reshape(D,[5,5]);
                        c1= E.*A;
                        I2(i,j) = sum(sum(c1));                
                    end 
                    
                case 'sharpen' 
                    if (MaskSize == 3)
                        filter = [0,-1,0;-1,5,-1;0,-1,0];
                        c= pixelWindow.*filter;
                        I2(i,j) = sum(sum(c));
                    else
                        A = [0,-1,1,-1,0;-1,2,-4,2,-1;-1,-4,13,-4,-1;-1,2,-4,2,-1;0,-1,1,-1,0];
                        D = pixelWindow;
                        E = reshape(D,[5,5]);
                        c1= E.*A;
                        I2(i,j) = sum(sum(c1));
                    end 
                    
                case 'emboss' 
                    if (MaskSize == 3)
                        filter = [-2,-1,0;-1,1,1;0,1,2];
                        c= pixelWindow.*filter;
                        I2(i,j) = sum(sum(c));
                    else
                        A = [0,0,0,0,0;0,-2,-1,0,0;0,-1,1,1,0;0,0,1,2,0;0,0,0,0,0];
                        D = pixelWindow;
                        E = reshape(D,[5,5]);
                        c1= E.*A;
                        I2(i,j) = sum(sum(c1));
                    end

                case 'smoothing' 
                    if (MaskSize == 3)
                        filter = [0.1100,0.1100,0.1100; 0.1100,0.1100,0.1100; 0.1100, 0.1100, 0.1100];
                        c= pixelWindow.*filter;
                        I2(i,j) = sum(sum(c));
                    else
                        A = [0.1100,0.1100,0.1100,0.1100,0.1100;0.1100,0.1100,0.1100,0.1100,0.1100;0.1100,0.1100,0.1100,0.1100,0.1100;0.1100,0.1100,0.1100,0.1100,0.1100;0.1100,0.1100,0.1100,0.1100,0.1100];
                        D = pixelWindow;
                        E = reshape(D,[5,5]);
                        c1= E.*A;
                        I2(i,j) = sum(sum(c1));
                    end   
                        
                case 'gaussianlow'               
                    if (MaskSize == 3)               
                        filter=[0.0113,0.0838,0.0113;0.0838,0.6193,0.0838;0.0113,0.0838,0.0113];
                        c= pixelWindow.*filter;
                        I2(i,j) = sum(sum(c));
                    else
                        A = [2,4,5,4,2;4,9,12,9,4;5,12,15,12,5;4,9,12,9,4;2,4,5,4,2];
                        D = pixelWindow;
                        E = reshape(D,[5,5]);
                        c1= E.*A;
                        I2(i,j) = sum(sum(c1));           
                    end 
                    
                case 'safyan'
                    if (MaskSize == 3)
                        filter = [-0.16,-0.067,0.178;-0.664,3.2300,0.6546;-0.689,-0.6457,-0.1695];
                        c= pixelWindow.*filter;
                        I2(i,j) = sum(sum(c));
                    else
                        A = [0.039968,0.039992,0.04,0.039992,0.039968;0.039992,0.040016,0.040024,0.040016,0.039992;0.04,0.040024,0.040032,0.040024,0.04;0.039992,0.040016,0.040024,0.040016,0.039992;0.039968,0.039992,0.04,0.039992,0.039968];
                        D = pixelWindow;
                        E = reshape(D,[5,5]);
                        c1= E.*A;
                        I2(i,j) = sum(sum(c1));
                    end
                  
                %Non-Linear    
                case 'max'
                    I2(i,j) =max(pixelWindow(:));
                 
                case 'min'
                    I2(i,j) =min(pixelWindow(:));
                 
                case 'range'
                    minval =min(pixelWindow(:));
                    maxval =max(pixelWindow(:));
                    I2(i,j) =maxval-minval;
                    
                %Edge Detections
                case'prewittTechnique'               
                    if (MaskSize == 3)
                        filter=[1,1,1;0,0,0;-1,-1,-1];
                        Gx= sum(sum(pixelWindow.*filter));
                        Gy= sum(sum(pixelWindow.*filter'));
                        I2(i,j) = sqrt(Gx.^2 + Gy.^2);
                    else
                        A = [9,9,9,9,9;9,5,5,5,9;-7,-3,0,-3,-7;-7,-3,-3,-3,-7;-7,-7,-7,-7,-7];
                        D = pixelWindow; 
                        E = reshape(D,[5,5]);
                        Gx= sum(sum(E.*A));
                        Gy= sum(sum(E.*A'));
                        I2(i,j) = sqrt(Gx.^2 + Gy.^2);
                    end    

                case'laplace' 
                    if (MaskSize == 3)
                        filter=[0,1,0; 1,-4,1; 0, 1, 0 ];
                        Gx= sum(sum(pixelWindow.*filter));
                        Gy= sum(sum(pixelWindow.*filter'));
                        I2(i,j) = sqrt(Gx.^2 + Gy.^2);
                    else
                        A = [-4,-1,0,-1,-4;-1,2,3,2,-1;0,3,4,3,0;-1,2,3,2,-1;-4,-1,0,-1,-4];
                        D = pixelWindow; 
                        E = reshape(D,[5,5]);
                        Gx= sum(sum(E.*A));
                        Gy= sum(sum(E.*A'));
                        I2(i,j) = sqrt(Gx.^2 + Gy.^2);    
                    end    

                case 'roberts' 
                    filterx = [-1,0,0;0,1,0; 0,0,0];
                    filtery = [0,-1,0;1,0,0;0,0,0];   
                    Gx= sum(sum(pixelWindow.*filterx));
                    Gy= sum(sum(pixelWindow.*filtery));                   
                    I2(i,j) = Gy + Gx;

                case 'sobel'                                 
                    filterx = [-1,0,1;-2,0,2;-1,0,1];
                    filtery = [1,2,1;0,0,0;-1,-2,-1];
                    Gx= sum(sum(pixelWindow.*filterx));
                    Gy= sum(sum(pixelWindow.*filtery));    
                    I2(i,j) = Gy + Gx;
                              
                otherwise
                    error('Filter type does not exist')        
            end

        end

MyFilteredImage = I2((imPad+1):(ySize-imPad),(imPad+1):(xSize-imPad));

    end
    
%Turns the input image I into I2    
I=I2;
    
end

end