function  startend=getCycle(PCG, true_index)
%to plot the amplitude vs time of every cycle
%Origial created: 20160327
%Last modified: 20160327
%Author: Charlene Her
%------------------------
numOfCycle=size(true_index,1);
startend=
%figure
for a= 1:numOfCycle-1
    %subplot(ceil(numOfCycle/2),2,a)
    %plot(PCG(true_index(a,1):true_index(a+1,1)-1))
    l=[l,true_index(a+1,1)-true_index(a,1)]; %length of each cycle
end
%subplot(ceil(numOfCycle/2),2,numOfCycle)
%plot(PCG(true_index(numOfCycle,1):length(PCG)))
l=[l,length(PCG)-true_index(numOfCycle,1)];

end