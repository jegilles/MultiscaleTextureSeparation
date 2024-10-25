# MultiscaleTextureSeparation
 Multiscale Texture Separation algorithm

 This package performs the Multiscale Texture Separation algorithm
% based on the cartoon + textures decomposition and adapted Fourier
% filtering (Littlewood-Paley or Curvelets).

The main function performing the decomposition is "Multiscale_Texture_Separation.m".

To plot the obtained decomposition, you can use the functions "MTS_Visualization.m" 
to visualize it in the spatial domain, or "MTS_Visualization_Fourier.m" to visualize 
it in the Fourier domain.

To save the obtained decomposition, you can use the function "Save_MTS_Curvelet.m"

All other functions are auxiliary functions needed by the above mentioned functions.
