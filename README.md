# Image-Mosaic
Image Mosaic is a project that creates a mosaic from the four images provided (.png file extensions). 
The perspective of one image is used as the base and is applied to the other images to create a 
seamless mosaic.

The main function is 'mosaic.m'. To run the function, 'mosaic.m' needs 'params.txt' as the only input. 
'params.txt' details the correspondences of the four images provided and dictates which image to use as the base. 
The other MATLAB functions are helper functions to complete the mosaic. The output filename is
also provided by the 'params.txt' file, and the output image is 'mosaic_out.tif'. 

The 'All perspectives' folder contains mosaics using different images as the base image. 
