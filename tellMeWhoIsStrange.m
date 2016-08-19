%Tell me who belongs to the strange cluster
strangeclus=[];
for a=1:length(cidx2);
    if cidx2(a)==2;
        strangeclus=[strangeclus;a];
    end
end
        