%save segidx

[num, txt, raw]=xlsread('referenceall.xlsx');
for a=:length(txt);
    recordName=txt{a,1};
cd('C:/Users/Administrator/Google Drive/heartSound/sample2016');
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
cd('C:/Users/Administrator/Google Drive/heartSound/sample2016');
PCG_resampled      = resample(PCG,springer_options.audio_Fs,Fs1); % resample to springer_options.audio_Fs (1000 Hz)

%% Running runSpringerSegmentationAlgorithm.m to obtain the assigned_states
[assigned_states] = runSpringerSegmentationAlgorithm(PCG_resampled, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole

%% We just assume that the assigned_states cover at least 2 whole heart beat cycle
A= getA(assigned_states);
true_index=A*(Fs1/1000);
numOfCycle=size(true_index,1);

%% get the start and end index of each cycle
segidx=getCycle1(PCG,true_index);

%%
cd('C:/Users/Administrator/Google Drive/heartSound/sample2016/segidx');
save([recordName,'.mat'], 'segidx');
end