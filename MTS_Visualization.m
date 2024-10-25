function MTS_Visualization(Low,LPw,type)

%=================================================================
%
% function MTS_Visualization(Low,LPw,type)
%
% This function permits to plot the outputs of the Multiscale 
% Texture Separation algorithm
%
% Input:
%   - Low: cell containing the cartoon parts
%   - LPw: cell containing the texture parts
%   - type: decomposition type (0=Littlewood-Paley ; 1=curvelet)
%           must be the same as the one used in the MTS algorithm
%
% Author: Jerome Gilles
% Institution: SDSU - Department of Mathematics and Statistics
% Email: jgilles@sdsu.edu
% Date: March, 1st, 2013
%
%=================================================================


if type==1 %curvelet case
    
    %plot the cartoon parts
    l=length(Low);

    figure;
    for s=1:l
        subplot(1,l,s);imshow(Low{s},[]);
%        spacesubplot(1,l,s);imshow(Low{s},[]);
    end
%    spaceplots(1,[0 0 0 0],[0 0])
    
    %plot the textures parts
    l=length(LPw);
    for s=1:l
        lo=length(LPw{s});
        for o=1:lo/2
            L{s}{o}=LPw{s}{o}+LPw{s}{o+lo/2};
        end
    end

    n=1;
    for s=1:l
        figure;
        lo=length(L{s});
        m=1;
        for o=1:lo
            subplot(lo/4,4,m);imshow(L{s}{o},[]);
%            spacesubplot(lo/4,4,m);imshow(L{s}{o},[]);
            m=m+1;
        end
%        spaceplots(s+1,[0 0 0 0],[-0.05 -0.3])
        n=n+1;
    end
    
else %Littlewood-Paley case
    p=length(Low);
    for n=1:p
        subplot(2,p,n);imshow(Low{n},[]);
        subplot(2,p,n+p);imshow(LPw{n},[]);    
%        spacesubplot(2,p,n);imshow(Low{n},[]);
%        spacesubplot(2,p,n+p);imshow(LPw{n},[]);    
    end
%    spaceplots(1,[0 0 0 0],[0 0])
end
