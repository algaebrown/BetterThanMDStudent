%% To see if there is a problem in segmentation in the strange group
% Author: Hsuan-lin Her
% Originally created: 20160822
% Last modified: 20160822

%import data
[num, txt, ~] = xlsread('referenceall.xlsx');
load strangeclusall;
load normalclusall;

%change dirctory
cd('segidx');

%combine clustering result to their real answer
num(strangeclus,2)=0; %0 means it is put into the strange cluster
num(normalclus,2)=1;

%now calculate mean, SD of length of all segment
for a=1:size(num,1);
    load(txt{a,1})
    length = (segidx(2,:)-segidx(1,:))/2000;
    num(a,3:6)=[mean(length), std(length), max(length),min(length)];
end

%average vs clus
plot(num(:,2),num(:,3),'+')
%average vs answer
plot(num(:,1),num(:,3),'+')
%average, answer, cluster
plot3(num(:,1),num(:,2),num(:,3),'+')
%SD
plot(num(:,2),num(:,4),'+')
plot(num(:,1),num(:,4),'+')
plot3(num(:,1),num(:,2),num(:,4),'+')

%range
load str
