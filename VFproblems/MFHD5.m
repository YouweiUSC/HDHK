function y=MFHD5(x,fidelity)
% Deep Gaussian Processes for Multi-fidelity Modeling
ndim = size(x,2);
A = 2:1:ndim;
y1 = (x(:,1)-1).^2+sum(A.*(2*x(:,2:end).^2-x(:,1:end-1)).^2,2);
switch fidelity
    case 1% low fidelity
        y = 0.9*y1+10;
%         y = 0.9*y1-sum(0.2*x(:,1:end-1).*x(:,2:end),2)-300;
    case 2 % higher fidelity 
        y = y1;
end
end