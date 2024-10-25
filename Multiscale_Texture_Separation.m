 function [Low,LPw]=Multiscale_Texture_Separation(im,J,FilterType)

%=====================================================================
%  function [Low,LPw]=Multiscale_Texture_Separation(im,J,FilterType)
%
% This function performs the Multiscale Texture Separation algorithm
% based on the cartoon + textures decomposition and adapted Fourier
% filtering (Littlewood-Paley or Curvelets).
%
% Input Parameters:
%
% im: input image
% J: the number of scales the algorithm must perform
% FilterType:  0 = Littlewood-Paley
%              1 = Curvelets
%
% Outputs:
%
% Low: structure which contains the "less oscillating" patterns of the
%      image or the cartoon parts
% LPw: structure which contains the textures at different scales 
%
% Author: Jerome Gilles
% Institution: SDSU - Department of Mathematics and Statistics
% Email: jgilles@sdsu.edu
% Date: June, 1st, 2012
%
%=====================================================================

im=double(im);
mu=roundpower10(size(im,1)/2);
n=1;
scale=-(log2(size(im,1))-1);

if J==0
    scalemax=0;
else
    scalemax=scale+J;
end

if FilterType==1  %we build the curvelet filter bank
   CFB=Curvelet_FilterBank(size(im,1),size(im,2),J);  
end


while scale<scalemax,
mu
    %------------------------
    % We do the decomposition
    %------------------------
    [u,w]=CartoonTexture_Aujol_Decomposition(im,1,mu,100,25);

    %-----------------------------------------------------------
    % We do the Littlewood-Paley Filtering or Curvelet Filtering
    %-----------------------------------------------------------
    if FilterType == 0  %Littlewood-Paley
        LPF=fftshift(LP_2D_Wavelet(scale,size(im,2),size(im,1)));
        LPw{n}=real(ifft2(LPF.*fft2(w)));
        Low{n}=im-LPw{n};
    else                %Curvelets
        Low{n}=im;
        for o=1:size(CFB{J-n+2},2)
            LPF=fftshift(CFB{J-n+2}{o});
            LPw{n}{o}=real(ifft2(LPF.*fft2(w)));
            Low{n}=Low{n}-LPw{n}{o};
        end
    end
    im=Low{n};
   
    scale=scale+1;
    n=n+1;
    mu=mu/2;
end
