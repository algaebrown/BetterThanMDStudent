colormap jet
a=front;
norm=normr(a(:,2:end-1));
nnorm=horzcat(a(:,1),norm,a(:,end));
image(norm*6000)