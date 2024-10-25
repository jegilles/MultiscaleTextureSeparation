function [u,v]=CartoonTexture_Aujol_Decomposition(in,lambda,mu,Niter,PNiter)

%==========================================================================
%
% function [u,v]=CartoonTexture_Aujol_Decomposition(in,lambda,mu,Niter,PNiter)
%
% This function performs the Cartoon+Texture decomposition (TV-G) based on
% the Chambolle's projector as used in the Aujol PhD and related papers.
%
% Input arguments:
% in : input image
% lambda : regularization parameter
% mu : upper bound for the texture (G) norm
% Niter : maximum number of iterations
% PNiter : number of iteration for Chambolle's projector
%
% Output arguments:
% u : cartoon part
% v : texture part
%
% Author: Jerome Gilles
% Institution: SDSU - Department of Mathematics and Statistics
% Email: jgilles@sdsu.edu
% Date: July, 18th, 2011
%
%==========================================================================

u=zeros(size(in));
v=zeros(size(in));
up=in;
vp=in;

tol=1e-6*norm(in(:),'fro');

n=0;
m(n+1)=max(norm(u-up,'fro'),norm(v-vp,'fro'));
while (n<Niter) && (m(n+1)>tol)
   n=n+1;
   up=u;
   vp=v;
   
   v=ChambolleProjector(in-u,mu,PNiter);
   u=in-v-ChambolleProjector(in-v,lambda,PNiter);
   
   m(n+1)=max(norm(u-up,'fro'),norm(v-vp,'fro'));
end
