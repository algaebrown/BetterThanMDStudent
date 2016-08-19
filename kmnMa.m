%%storeclus
d=xlsread('cluster2-7-0426.xlsx');
ma=zeros(2,7);
for a=1:size(d,2);
    for b=3:size(d,1);
        if d(2,a)==1;
        ma(1,d(b,a))=ma(1,d(b,a))+1;
        else
        ma(2,d(b,a))=ma(2,d(b,a))+1;
        end
    end
end
ma1=ma/191;