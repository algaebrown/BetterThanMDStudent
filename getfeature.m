function featureVector=getfeature(recordName)
%main
%Origial created: 20160324
%Last modified: 20160327
%Author: Charlene Her
%------------------------

%% load data
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
cd('../../sample2016');
PCG_resampled      = resample(PCG,springer_options.audio_Fs,Fs1); % resample to springer_options.audio_Fs (1000 Hz)

%% Running runSpringerSegmentationAlgorithm.m to obtain the assigned_states
[assigned_states] = runSpringerSegmentationAlgorithm(PCG_resampled, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole

%% We just assume that the assigned_states cover at least 2 whole heart beat cycle
A= getA(assigned_states);
true_index=A*(Fs1/1000);

%% get the start and end index of each cycle
startend=getCycle(PCG,true_index);

%% devide into 10 parts each cycle
partitionIndex=partitionCycle(10, startend);

%% add zero and fft
[fftolp,~] = alignedFFTolp( partitionIndex, PCG );
[fftnmr,~]= alignedFFT(partitionIndex,PCG);
fftolp=fftolp(1:9,:);

%% fft1 become cyclewise and plot (data visualization)
fft2olp=transfft(fftolp);
fft2nmr=transfft(fftnmr);

%% unroll and arrange it into 3500 feature vector
[avgolp, ~]=unrollfft(fft2olp);
[avgnmr, ~]=unrollfft(fft2nmr);
featureVector=normr([avgnmr,avgolp]);

end



