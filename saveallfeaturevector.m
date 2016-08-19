%save feature vector
%20160611
%Charlene Her

%% =====import=====
[num,txt,raw]=xlsread('referenceall.xlsx');
allavg=[];%save average feature vector of each sample to this matrix
for a=1:size(txt,1) %%txt contains the name of the heart sound(1) and its answer(2);
    recordName=txt{a,1};
    answer=num(a,1);
    %% Load the trained parameter matrices for Springer's HSMM model.
    % The parameters were trained using 409 heart sounds from MIT heart
    % sound database, i.e., recordings a0001-a0409.
    load('Springer_B_matrix.mat');
    load('Springer_pi_vector.mat');
    load('Springer_total_obs_distribution.mat');
    %recordName='a0001';

    
        %% Load data and resample data
     springer_options   = default_Springer_HSMM_options;
    cd(['../training/training-',recordName(1)]);
    [PCG, Fs1, nbits1] = wavread([recordName '.wav']);  % load data
    
    
    %% import segidx
   cd('C:/Users/Administrator/Google Drive/heartSound/sample2016/segidx');
   load([recordName '.mat']);
   startend=segidx;
   cd('C:/Users/Administrator/Google Drive/heartSound/sample2016');
%% =====derived from getfeature.m=====

    %% devide into 10 parts each cycle
    partitionIndex=partitionCycle(10, startend);

    %% add zero and fft
    [fftolp,parCyc] = alignedFFTolp( partitionIndex, PCG );
    [fftnmr,parCycm]= alignedFFT(partitionIndex,PCG);
    fftolp=fftolp(1:9,:);
    %fft1: contain complex fft
    %parCyc: partitioned cycle, zeros added to 250 points

    %% fft1 become cyclewise and plot (data visualization)
    fftall={transfft(fftnmr),transfft(fftolp)};

%% =====now generated the feature vector(normal2000-overlap-answer)=====(derived from visualfft2.m)
    cycledata1=[];
    avgdata=[];
    for m=1:2
        fft=fftall{1,m};
        cycledata=[];
        for n=1:length(fft);
            roww=reshape((fft{1,n})',[1,size(fft{1,n},1)*size(fft{1,n},2)]);
            cycledata=[cycledata;roww];
        end
        avg=sum(cycledata,1)/size(cycledata,1);
        cycledata1=horzcat(cycledata1,cycledata);
        avgdata=horzcat(avgdata,avg);
    end
    cd('C:/Users/Administrator/Google Drive/heartSound/sample2016/allcycle');
    save([recordName,'.mat'], 'cycledata1');
    cd('C:/Users/Administrator/Google Drive/heartSound/sample2016');
    allavg=[allavg;avgdata];
    %input('onecycle');
end
xlswrite('avgallfalldata.xlsx',allavg);