% see if every cycle in a sample is homogeneous
[num, txt, raw]=xlsread('REFERENCE.xlsx');
avg=[];
allcyc=[];
for a=244:length(txt);
    fft2= getfeature(txt{a,1});
    %figure;
    %colormap jet;
    cycledata=[];
    for n=1:length(fft2);
        roww=reshape((fft2{1,n})',[1,size(fft2{1,n},1)*size(fft2{1,n},2)]);
        cycledata=[cycledata;[str2num(txt{a,1}(2:end)),roww, num(a)]];
        %subplot(ceil(length(fft2)/6),6,n)
        %image(fft2{1,n}/sum(sum(fft2{1,n}))*1250*60);
    end
    %print(['result' num2str(num(a)) txt{a,1}  ],'-dpng');
    avg=[avg;sum(cycledata,1)/size(cycledata,1)];
    allcyc=[allcyc;cycledata];

end
