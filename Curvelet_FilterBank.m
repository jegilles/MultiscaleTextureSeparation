function CFB=Curvelet_FilterBank(m,n,J)

%==============================================================
% function CFB=Curvelet_FilterBank(m,n,J)
%
%	This function creates a curvelet filter bank in the Fourier
% domain corresponding to a scale J for images of size m x n
%
% Inputs:
%		-m: image height
%		-n: image width
%		-J: wanted scale
%
%	Outputs:
%		CFB: cells containing the different filters CFB{s}{w} 
%				 where s indexes the scales and w the orientations
%
% Author: Jerome Gilles
% Institution: SDSU - Department of Mathematics and Statistics
% Email: jgilles@sdsu.edu
% Date: June, 1st, 2012
%==============================================================

X = zeros(m,n);

%create a curvelet structure by the forward curvelet transform
%C = fdct_wrapping(X,0,1,J+1,8);
C = fdct_wrapping(X,1);

%Ns=size(C,2);  %number of scales

%build the filter bank
for j=0:J
%specify one curvelet
s = J-j+1; %the scale
No=size(C{s},2); %number of orientations

    for w=1:No
        [A,B] = size(C{s}{w});
        a = ceil((A+1)/2);
        b = ceil((B+1)/2);
        C{s}{w}(a,b) = 1;

        %adjoint curvelet transform
        %Y = ifdct_wrapping(C,0,m,n);
        Y = ifdct_wrapping(C,1);

        %store the Fourier transform of the curvelet
        CFB{s}{w} = abs(ifftshift(fft2(fftshift(Y))));
        CFB{s}{w} = CFB{s}{w}/max(max(CFB{s}{w}));
        C{s}{w}(a,b) = 0;
    end
end
