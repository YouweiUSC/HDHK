function y=MFHD2(x,fidelity)
% Deep Gaussian Processes for Multi-fidelity Modeling
switch fidelity
    case 1% low fidelity
        A = [-6.089 -17.164 -34.054 -5.914 -24.721 -14.986 -24.100 -10.708 -26.662 -22.179];
    case 2 % higher fidelity 
        A = [-5 -10 -30 -5 -25 -15 -20 -10 -25 -20];
end
y = sum(exp(x).*(A+x-log(sum(exp(x),2))),2);
end