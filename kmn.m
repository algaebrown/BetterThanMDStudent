%% K-mean clsutering 
%originally created: 20160426
%last modified: 20160611
%Author: Hsuan-Lin Her

%% load data
data=xlsread('avgallfalldataWithName.xlsx');
allidx=[1:size(data,1)];
load strangeclusall;
rmv1=strangeclus';
%rmv1=[115,121,131,139,157,313,994,1619,1621,1622,1623,1624,1625,1653,1742,1749,1761,1762,1763,1764,1821,1823,1824,1826,1844,1904,2143,2144,2145,2146,2147,2148,2149,2150,2151,2152,2153,2154,2155,2253,2403,2590,2591,2592,2593,2594,2595,2602,3460,3549,3550,3551,3552,3555,3556,3557,3558,3560,3561,3869,3874,3877,3879,3887,3889,4268,4325,4329,4356,4374,4376,4379,4382,4383,4384,4385,4386,4387,4388,4389,4391,4392,4393,4394,4395,4396,4397,4399,4402,4404,4517,4518,4519,4520,4521,4522,4523,4524,4525,4526,4527,4528,4529,4530,4531,4532,4533,4534,4535,4563,4803,4908,5098,5107,5110,5122,5123,5302,5309,5369,5424,5425,5426,5427,5466,5486,5527,5558,5559,5560,5562,5563,5564,5565,5571,5572,5596,5597,5599,5600,5609,5610,5611,5612,5613,5637,5863,5864,5865,5866,5867,5899,5900,5901,5902,5903,5904,5905,5997,6000,6001,6002,6004,6006,6007,6062,6063,6064,6065,6066,6067,6068,6069,6071,6072,6074,6075,6077,6244,6245,6246,6247,6248,6249,6250,6536,6658,6659,6660,6661,6662,6663,6748,6749,6750,6751,6752,6753,6754,6755,6756,6757,6758,6759,6932,7079,7120,7121,7126,7127,7147,7380,7412,7413,7414,7415,7416,7417,7418,7419]
cleandata= setxor(allidx,rmv1);
idx=data(cleandata,1);
obs=normr(data(cleandata,2:end-1));
grp=data(cleandata,end);

%% previously selected features
%feature=xlsread('seletefeatureNormP.xlsx');
%howManyFeature=40;
load fsortpall;
numOfF=40;
selectIdx=featureIdxSortbyP(1:numOfF)
%% Let's cluster
J=[];
storeclus=[idx';grp'];
%figure;
for Ncluster=1:10;
%Ncluster=2;
    [cidx2,cmeans2,sumd] = kmeans(obs(:,selectIdx),Ncluster,'dist','sqeuclidean');
    %subplot(2,3,Ncluster-1);
    %[silh2,h] = silhouette(obs(:,feature(2,1:howManyFeature)),cidx2,'sqeuclidean');
    J=[J,sum(sumd)];
    %storeclus=[storeclus;cidx2']
end

%% plotting J (elbow method to determine number of clusters
plot(J)
xlabel('Number of cluster');
ylabel('sum of distance to centroid');


 