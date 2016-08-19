function classifyResult = challenge(recordName )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% get feature vector
[fft2olp, fft2nmr]=getfeature(recordName);
[avgolp, ~]=unrollfft(fft2olp);
[avgnmr, ~]=unrollfft(fft2nmr);

load fsortp;
numOfF=40;
selectIdx=featureIdxSortbyP(1:numOfF)
featureVector=normr([avgnmr,avgolp]);
featureVector=featureVector(selectIdx);

%% prediction
%step1 pretrained kmn centroid
load cmeans2;
centroid1= cmeans2(1,:); %class 1,-1
centroid2= cmeans2(2,:); %class 0
dist1=sum((featureVector-centroid1).^2);
dist2=sum((featureVector-centroid2).^2);
if dist1> dist2
    classifyResult=0;
else
    %step2 pretrained ANN
    load net5;
    o=net(featureVector');
    if o(1)>o(2)
        classifyResult=1;
    else classifyResult=-1;
    end
end




end

