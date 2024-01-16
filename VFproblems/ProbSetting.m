function ProbInfo = ProbSetting(fun_name,sam_base,max_iter)
cost_ratio=4;   
Nobj = 1;          
fidlty = [1 2];
if nargin<2
    sam_base = [6 3];   
end
if nargin<3
    max_iter = 30;
end
switch fun_name
    case 'MFHD1'
        num_vari = 2;        
        DS = [-5 0;10 15]; 
        optimum=[]; 
    case 'MFHD2'
        num_vari = 10;        
        DS = [-5*ones(1, num_vari);5*ones(1, num_vari)]; 
        optimum=[]; 
    case 'MFHD3'
        num_vari = 10;        
        DS = [-3*ones(1, num_vari);3*ones(1, num_vari)]; 
        optimum=[]; 
    case 'MFHD4'
        num_vari = 10;        
        DS = [-10*ones(1, num_vari);11*ones(1, num_vari)]; 
        optimum=[]; 
    case 'MFHD5'
        num_vari = 16;        
        DS = [-5*ones(1, num_vari);5*ones(1, num_vari)]; 
        optimum=[]; 
    case 'MFHD6'
        num_vari = 30;        
        DS = [-3*ones(1, num_vari);3*ones(1, num_vari)]; 
        optimum=[]; 
    case 'MFHD7'
        num_vari = 50;        
        DS = [-2*ones(1, num_vari);4*ones(1, num_vari)]; 
        optimum=[]; 
    case 'MFHD8'
        num_vari = 100;        
        DS = [-3*ones(1, num_vari);3*ones(1, num_vari)]; 
        optimum=[]; 
    case 'Multifi_1Da'% 1-objective 2 fidelity
         num_vari = 1;        
         DS = [zeros(1, num_vari);ones(1, num_vari)]; 
         optimum=-6.020740;  
end
num_sam = sam_base*num_vari;
ProbInfo.CostRatio = cost_ratio;
ProbInfo.num_vari = num_vari;
ProbInfo.Nobj = Nobj;
ProbInfo.fidlty = fidlty;
ProbInfo.num_sam = num_sam;
ProbInfo.max_iter = max_iter;
ProbInfo.DS = DS;
ProbInfo.optimum = optimum;
end 
