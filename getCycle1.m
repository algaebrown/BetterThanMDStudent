function  startend=getCycle1(PCG, true_index)
%startend(1,a) is the index of the start of the a-th cycle
%startend(2,a)is the index of the end of the a-cycle
%Origial created: 20160327
%Last modified: 20160406
%Author: Charlene Her
%------------------------
numOfCycle=size(true_index,1);
startend=zeros(2,numOfCycle)
%figure
for a= 1:numOfCycle-1
    %subplot(ceil(numOfCycle/2),2,a)
    %plot(PCG(true_index(a,1):true_index(a+1,1)-1))
    startend(1,a)=true_index(a,1); %start of each cycle
    startend(2,a)=true_index(a+1,1)-1;%end of each cycle
end
%subplot(ceil(numOfCycle/2),2,numOfCycle)
%plot(PCG(true_index(numOfCycle,1):length(PCG)))
startend(1,numOfCycle)=true_index(numOfCycle,1);
startend(2,numOfCycle)=length(PCG);

end