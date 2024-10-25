function Save_MTS_Curvelet(Low,LPw)

%=========================================================================
%
% function Save_MTS_Curvelet(Low,LPw)
%
% Save each subband image in separate files named 'MTSC_Lowx.png' and 
% 'MTSC_xy.png' where x and y are the indices of the scales and directions, 
% respectively. The images are renormalized between 0 and 1.
%
% Author: Jerome Gilles
% Institution: SDSU - Department of Mathematics and Statistics
% Email: jgilles@sdsu.edu
% Year: 2015
% Version: 1.0
% ========================================================================

% save the cartoon parts first
nr=length(Low);

for r=1:nr;
    gname=sprintf('MTSC_Low%d.png',r);
    imwrite((Low{r}-min(Low{r}(:)))/(max(Low{r}(:))-min(Low{r}(:))),gname,'png');
end

% save texture parts next
nr=length(LPw);
for r=1:nr;
    nc=length(LPw{r});
    for c=1:nc;
        gname=sprintf('MTSC_%d%d.png',r,c);
        imwrite((LPw{r}{c}-min(LPw{r}{c}(:)))/(max(LPw{r}{c}(:))-min(LPw{r}{c}(:))),gname,'png');
    end
end
