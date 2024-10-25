function p=ChambolleProjector(in,lambda,Niter)

%======================================================
%
%  function p=ChambolleProjector(in,lambda,Nitermax)
%
%  This function compute the Chambolle's projector
%  used to compute the G-norm in the cartoon+texture
%  decomposition model of Aujol
%
%  Input parameter:
%  in: input image
%  lambda: Chambolle's parameter
%  Niter: maximum number of iteration
%
%  Output:
%  p: result of the projector
%
%  Author: Jerome Gilles
%  Institution: SDSU - Department of Mathematics and Statistics
%  Email: jgilles@sdsu.edu
%  Date: July, 14th, 2011
%
%======================================================

tau=0.24;
c=tau/lambda;
n=0;
maxerror=0.001*norm(in(:),'fro');

[H,L]=size(in);

%Variable initialization
p=zeros(size(in));
w=zeros(size(in));
phix=zeros(size(in));
phiy=zeros(size(in));
dxw=zeros(size(in));
dyw=zeros(size(in));

err=maxerror+1;
while (n<Niter) && (err>maxerror),
    %update w
    w=lambda*w-in;
    
    %compute w gradients and its norm
    dyw(2:H-1,:)=0.5*(w(3:H,:)-w(1:H-2,:));
    dyw(1,:)=0.5*(w(2,:)-w(1,:));
    dyw(H,:)=0.5*(w(H,:)-w(H-1,:));
    
    dxw(:,2:L-1)=0.5*(w(:,3:L)-w(:,1:L-2,:));
    dxw(:,1)=0.5*(w(:,2)-w(:,1));
    dxw(:,L)=0.5*(w(:,L)-w(:,L-1));
    norm1=sqrt(dxw.^2+dyw.^2);
    
    %update the projector
    npx=(phix+c*dxw)./(1+c*norm1);
    npy=(phiy+c*dyw)./(1+c*norm1);
    err=max(norm(phix-npx,'fro'),norm(phiy-npy,'fro'));
    
    phix=npx;
    phiy=npy;
    
    %compute the divergence of phix and phiy
    dyw(2:H-1,:)=0.5*(phiy(3:H,:)-phiy(1:H-2,:));
    dyw(1,:)=0.5*(phiy(2,:)-phiy(1,:));
    dyw(H,:)=0.5*(phiy(H,:)-phiy(H-1,:));
    dxw(:,2:L-1)=0.5*(phix(:,3:L)-phix(:,1:L-2,:));
    dxw(:,1)=0.5*(phix(:,2)-phix(:,1));
    dxw(:,H)=0.5*(phix(:,L)-phix(:,L-1));
    w=dxw+dyw;
    n=n+1;
end
p=lambda*w;
