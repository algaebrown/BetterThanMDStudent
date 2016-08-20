function [fft1,parCyc] = alignedFFT( partitionIndex, PCG )
%to add zero to partitioned cycle and then do FFT
% Originally created: 20160406
% Last Modified: 20160406
% Author: Hsuan-Lin Her

par=reshape(partitionIndex,[1,size(partitionIndex,1)*size(partitionIndex,2)]);
par=[par,length(PCG)];
p=250;
par0=cell(size(partitionIndex));
parfft=cell(size(partitionIndex));
for a=1:length(par)-1;
    cut=zeros(p,1);
    l=par(a+1)-par(a)+1;
    if 1>p
    cut(1:p)=PCG(par(a):par(a)+p-1);
    elseif l<=p
        cut(1:l)=PCG(par(a):par(a+1));
    end
    par0{a}=cut;
    parfft{a}=fft(cut);
end
parCyc=reshape(par0,size(partitionIndex));
fft1=reshape(parfft,size(partitionIndex));


end

