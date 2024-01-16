function y=MFHD3(x,fidelity)
% Deep Gaussian Processes for Multi-fidelity Modeling
switch fidelity
    case 1% low fidelity
        y = sum(0.9*x(:,2:end).^4+2.2*x(:,1:end-1).^2-1.8*x(:,1:end-1).*x(:,2:end).^2+0.5,2);
    case 2 % higher fidelity 
        y = sum((x(:,2:end).^2-x(:,1:end-1)).^2+(x(:,1:end-1)-1).^2,2);
end
end