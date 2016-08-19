function fft2= transfft(fft1)
%gets abs of fft and transform into 10*125 matrix
%   Detailed explanation goes here
fft2=cell(1,size(fft1,2));
for a=1:size(fft1,2); %how many cycle
    cycle=[];
    for b=1:size(fft1,1); %how many partition
        cycle=[cycle;abs(transpose(fft1{b,a}(1:length(fft1{b,a})/2)))]; %cycle is 10*125(half of p)
    end
    fft2{1,a}=cycle;
end
end

