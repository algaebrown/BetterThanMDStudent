function segmentedCycle=getSeg(recordName)
%getSeg: segment heart sound recordings

%input: record name
%output:segmentedCycle: a cell containing every cycle of the recordings.
%segmentedCycle will be saves to local directory with the name
%'recordNameSeq.mat'. ex: a0001-->a0001Seg.mat

%Origial created: 20160324
%Last modified: 20160329
%Author: Charlene Her
%------------------------

%% load data
%% Load the trained parameter matrices for Springer's HSMM model.
% The parameters were trained using 409 heart sounds from MIT heart
% sound database, i.e., recordings a0001-a0409.
load('Springer_B_matrix.mat');
load('Springer_pi_vector.mat');
load('Springer_total_obs_distribution.mat');

%% Load data and resample data
springer_options   = default_Springer_HSMM_options;
[PCG, Fs1, nbits1] = wavread([recordName '.wav']);  % load data
PCG_resampled      = resample(PCG,springer_options.audio_Fs,Fs1); % resample to springer_options.audio_Fs (1000 Hz)

%% Running runSpringerSegmentationAlgorithm.m to obtain the assigned_states
[assigned_states] = runSpringerSegmentationAlgorithm(PCG_resampled, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole

%% We just assume that the assigned_states cover at least 2 whole heart beat cycle
A= getA(assigned_states);
true_index=A*(Fs1/1000);
numOfCycle=size(true_index,1);

%% Segmented Cycle
segmentedCycle=cell(numOfCycle,1);
for a=1:numOfCycle-1
    segmentedCycle{a}=PCG(true_index(a,1):true_index(a+1,1)-1);
end
segmentedCycle{numOfCycle}=PCG(true_index(numOfCycle,1):length(PCG));

%% plot
figure
for b=1:numOfCycle
    subplot(ceil(numOfCycle/2),2,b);
    plot(segmentedCycle{b});
end

%% Save file
save([recordName 'Seg.mat'],'segmentedCycle');
end

