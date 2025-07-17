function g=plot_err_patch(x,y,e,col1,col2);

x=x(:)';
y=y(:)';
e=e(:)';

ye1=y+e;
ye2=y-e; ye2=ye2(end:-1:1);
ye=[ye1,ye2];
xe=[x,x(end:-1:1)];

hold on;
h=patch(xe,ye,col2,'linestyle','none');
g=plot(x,y,'color',col1);