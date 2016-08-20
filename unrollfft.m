function [avg, cycledata]=unrollfft(fft2)
cycledata=[];
    for n=1:length(fft2);
        roww=reshape((fft2{1,n})',[1,size(fft2{1,n},1)*size(fft2{1,n},2)]);
        cycledata=[cycledata;roww];
        %subplot(ceil(length(fft2)/6),6,n)
        %image(fft2{1,n}/sum(sum(fft2{1,n}))*1250*60);
    end
    avg=sum(cycledata,1)/size(cycledata,1);
    
end