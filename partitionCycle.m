function partitionIndex = partitionCycle( cut, startend )
%Originally created: 20160406
%Last Modified: 20160406
%Author:Hsuan-Lin Her
%   to partition cycles
% input: cut-->how many parts do you wnat to segment?
% input: startend-->2*n array containing the start and the end of each
% array
%output
partitionIndex=zeros(cut,size(startend,2));
partitionIndex(1,:)=startend(1,:);
for a=1:size(startend,2);
    thres=(startend(2,a)-startend(1,a))/cut;
    for b=2:cut;
        partitionIndex(b,a)=round(thres*(b-1)+partitionIndex(1,a));
    end
end

end
