function ymw=LP_2D_Wavelet(J,W,H)

%==============================================
%
% function ymw=LP_2D_Wavelet(J,W,H)
%
% Generate the 2D Littlewood-Paley wavelet in 
% the Fourier domain associated to scale J<0
%
% Inputs:
%   - J: scale
%   - W: image width
%   - H: image height
%
% Output:
%   - ymw: 2D filter
%
% Author: Jerome Gilles
% Institution: SDSU - Department of Mathematics and Statistics
% Email: jgilles@sdsu.edu
% Date: June, 1st, 2012
%
%==============================================

Mi=floor(W/2);
Mj=floor(H/2);

b1=2*pi/3;
b2=4*pi/3;
b3=8*pi/3;

j3=3/(2*pi);
j4=pi/2;
j5=3/(4*pi);
j6=2^J*b2;

ymw=zeros(H,W);

for i=0:W-1
   for j=0:H-1
      k1=double(i-Mi);
      k2=double(j-Mj);
      
      w=j6*sqrt(k1^2+k2^2);
      
      if (abs(w)>=b1) && (abs(w)<=b2)
        arg=sin(j4*betaLP(j3*abs(w)-1));
        ymw(j+1,i+1)=arg;
      elseif (abs(w)>=b2) && (abs(w)<=b3)
        arg=cos(j4*betaLP(j5*abs(w)-1));
        ymw(j+1,i+1)=arg;
      end
   end
end
