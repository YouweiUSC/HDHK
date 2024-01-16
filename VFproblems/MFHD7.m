function y=MFHD7(x,fidelity)
% Deep Gaussian Processes for Multi-fidelity Modeling
ndim = size(x,2);
A = 1:1:ndim;
y1 = sum(A.*(x.^2+x.^4),2);
switch fidelity
    case 1% low fidelity
        y = 0.8*y1-sum(A.*x.^2/10+x,2)-25;
    case 2 % higher fidelity 
        y = y1;
end
end