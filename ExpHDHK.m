% test the efficient modeling strategy of high-dimensional HK
addpath('MLHK','VFproblems')
%% 
clear;clc;
n_run = 2;
GenNewSamples = 1;
VariableNamesT = {'KDIC','GA','HighDim'};
N_method = length(VariableNamesT);
for iprob = [1 2 3 4 5 6 7 8]
    Prob = sprintf('MFHD%d',iprob);
    sam_base = [10 5];
    ProbInfo = ProbSetting(Prob,sam_base);
    [ndim,DS,nsample] = deal(ProbInfo.num_vari,ProbInfo.DS,ProbInfo.num_sam);
    N_test = min(ndim*200,5000);
    R2 = zeros(n_run,N_method);RMSE = R2; MAE = R2; ElaspeTime = R2;
    disp(' overall step 0: generate test samples ')
    test_x = repmat(DS(1,:),N_test,1) + repmat(DS(2,:)-DS(1,:),N_test,1) ...
        .*lhsdesign(N_test,ndim,'criterion','maximin','iterations',1000);
    test_y = feval(Prob, test_x,2);
    %% --------------------------------------
    for irun=1:n_run
        [R2(irun,:),RMSE(irun,:),MAE(irun,:),ElaspeTime(irun,:)] = ...
            RunModeling(Prob,irun,ndim,nsample,DS,N_method,N_test,test_x,test_y);
    end
    %% metric statistic
    RMSE(n_run+1,:) = mean(RMSE(1:n_run,:),1);
    MAE(n_run+1,:)  = mean(MAE(1:n_run,:),1);
    R2(n_run+1,:)   = mean(R2(1:n_run,:),1);
    ElaspeTime(n_run+1,:)  = mean(ElaspeTime(1:n_run,:),1);
    RMSE(n_run+2,:) = std(RMSE(1:n_run,:),1);
    MAE(n_run+2,:)  = std(MAE(1:n_run,:),1);
    R2(n_run+2,:)   = std(R2(1:n_run,:),1);
    ElaspeTime(n_run+2,:)  = std(ElaspeTime(1:n_run,:),1);
    rownamesT=cell(n_run+2,1);
    for iname = 1:n_run
        rownamesT{iname} = ['run' num2str(iname)];
    end
    rownamesT{n_run+1} = 'mean';
    rownamesT{n_run+2} = 'std';
    %%
    TR2 = array2table(R2,'rownames',rownamesT, 'VariableNames',VariableNamesT);
    TRMSE = array2table(RMSE,'rownames',rownamesT, 'VariableNames',VariableNamesT);
    TMAE = array2table(MAE,'rownames',rownamesT, 'VariableNames',VariableNamesT);
    TTime = array2table(ElaspeTime,'rownames',rownamesT, 'VariableNames',VariableNamesT);
    %% 
    disp(' overall step 1: save metric ')
    save(['Results/Res_' Prob '_' num2str(ndim) '_.mat'], ...
                'TR2', 'TRMSE', 'TMAE','TTime','test_x','test_y');
end