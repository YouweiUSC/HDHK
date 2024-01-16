% test the efficient modeling strategy of high-dimensional HK
%% prepare data
clear;
addpath('MLHK')
disp(' step 1: prepare data')
load('Rotor37dat\Rotor37.mat')
ncase = 1;%
resFile = 'Rotor37dat/ResRotor37eta_3.mat';
y_LF = cdat_LF.eta.Variables;
y_HF = cdat_HF.eta.Variables;
test_x = cdat_test.x.Variables;
test_y = cdat_test.eta.Variables;
x_LF = cdat_LF.x.Variables;
x_HF = cdat_HF.x.Variables;
sample_x = {x_LF;x_HF};
sample_y = {y_LF;y_HF};
%% modeling
disp(' step 2: modeling')
N_method = 3;
model = cell(N_method,1);
% ----------------------
disp('KDIC')
options = [];
options.hyperest='HighDim';
optionsLF = HKdefaultopts(options,size(x_LF,2));
tic%kriging
model{1} = dacefit(x_HF, y_HF, optionsLF);
ElaspeTime(1,1) = toc;
disp('GA')
options1 = [];
options1.hyperest='GA';
tic%GEK
model{2} = train_MLHK(sample_x,sample_y, options1);
ElaspeTime(1,2) = toc;
% ----------------------
disp('HDHK')
options2 = [];
options2.hyperest='NC';
tic%PGEK
model{3} = train_MLHK(sample_x,sample_y, options2);
ElaspeTime(1,3) = toc;
%% --------------------------------------
% prediction
disp(' step 3: prediction ')
y_pred = zeros(size(test_x,1),N_method);
y_pred(:,1) = predictor( test_x,  model{1});
for ipred = 2:N_method
    y_pred(:,ipred) = pred_MLHK( test_x, model{ipred});
end
%% --------------------------------------
% accuracy metric calculation
disp(' step 4: accuracy metric calculation ')
for iM = 1:N_method
    [R2(1,iM),RMSE(1,iM),MAE(1,iM)] = ...
        ModelAccuracyMetric(y_pred(:,iM),test_y);
end
%% visulization
close all;
figure1 = figure('Unit','Centimeters','Position',[10 10 10 8]);
% 
axes1 = axes('Parent',figure1);
set(axes1,'FontName','Times New Roman');
hold on;box on
scstr={'ro','b^','ks'};
name1 = {'KDIC','HKC','HKHD'};
xlimdata = [min([y_pred(:,1); y_pred(:,2);test_y]) max([y_pred(:,1); y_pred(:,2);test_y])];
fplot(@(x) x, xlimdata,  ...
    'Linewidth',1.5,'LineStyle','--','Color','k')
for iM = 1:N_method
    sct(iM) = plot(test_y,y_pred(:,iM),scstr{iM},'DisplayName',name1{iM});
end
xlabel({'Simulated value'});
ylabel({'Predicted value'});
xlim(xlimdata);ylim(xlimdata);
legend([sct(1) sct(2) sct(3)],'KDIC','HKC','HKHD','location','northwest','Box','on')
%% save data
disp(' save data ')
save(resFile,'R2', 'RMSE', 'MAE','ElaspeTime','model');

