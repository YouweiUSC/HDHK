function y=MFHD1(x,fidelity)
% Deep Gaussian Processes for Multi-fidelity Modeling
% [0,1]x[0,1]
xx1=x(:,1);
xx2=x(:,2);
f=@(x1,x2)((x2-1.275*(x1/pi).^2-5*x1/pi-6).^2+10*(x1-0.125/pi).*cos(x1));
switch fidelity
    case 1% low fidelity
        y = 0.8*f(xx1,xx2)-2.5*xx2-30;
    case 2 % higher fidelity 
        y = f(xx1,xx2);
end
end