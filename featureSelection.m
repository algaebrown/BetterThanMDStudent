%feature selection
%20160426 initially created

 data=xlsread('avgallfalldataWithName.xlsx');

grp=data(:,end);
obs=normr(data(:,1:end-1));

holdoutCVP = cvpartition(grp,'holdout',56);
dataTrain = obs(holdoutCVP.training,:);
grpTrain = grp(holdoutCVP.training);
dataTrainG1 = dataTrain(grp2idx(grpTrain)==1,:);
dataTrainG2 = dataTrain(grp2idx(grpTrain)==2,:);
[h,p,ci,stat] = ttest2(dataTrainG1,dataTrainG2,'Vartype','unequal');
ecdf(p);
xlabel('P value');
ylabel('CDF value')

[psort,featureIdxSortbyP] = sort(p,2); % sort the features
testMCE = zeros(1,14);
resubMCE = zeros(1,14);
nfs = 5:5:70;
classf = @(xtrain,ytrain,xtest,ytest) ...
             sum(~strcmp(ytest,classify(xtest,xtrain,ytrain,'quadratic')));
resubCVP = cvpartition(length(grp),'resubstitution')
for i = 1:14
   fs = featureIdxSortbyP(1:nfs(i));
   testMCE(i) = crossval(classf,obs(:,fs),grp,'partition',holdoutCVP)...
       /holdoutCVP.TestSize;
   resubMCE(i) = crossval(classf,obs(:,fs),grp,'partition',resubCVP)/...
       resubCVP.TestSize;
end
 plot(nfs, testMCE,'o',nfs,resubMCE,'r^');
 xlabel('Number of Features');
 ylabel('MCE');
 legend({'MCE on the test set' 'Resubstitution MCE'},'location','NW');
 title('Simple Filter Feature Selection Method');