function [inputsADA, targetsADA] = useADASYN(inputs, targets)


for a=1:length(targets)
    if targets(a)==-1;
        targets(a)=0;
    end
end

[inputsADA, targetsADA] = ADASYN(inputs, targets);

for a=1:length(targetsADA)
    if targetsADA(a)==0;
        targetsADA(a)=-1;
    end
end



