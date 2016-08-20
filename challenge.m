function classifyResult = challenge(recordName )
%challange.m: input record's name, output the result
%   contain the trainined parameters.

%% get feature vector
featureVector=getfeature(recordName);

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
    load net0709ADASYN;
    o=net(featureVector');
    if o(1)>o(2)
        classifyResult=1;
    else classifyResult=-1;
    end
end




end

%% local functions


