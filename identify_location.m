function [bolt_data,hole_data]=identify_location(bolt_data,hole_data)
count=0;
for ii=1:9 %iterate over bolt rows
    for jj=1:9 %iterate over hole rows
        if bolt_data(ii,1)==hole_data(jj,1) && bolt_data(ii,2)==hole_data(jj,2) && bolt_data(ii,3)==hole_data(jj,3) %check if x, y, and colors match up
            count=count+1;
            bolt2del(count)=ii;
            hole2del(count)=jj;
        end
    end
end
bolt_data(bolt2del,:)=[]; %delete correctly placed bolts
hole_data(hole2del,:)=[]; %deleted holes with the correct bolts
end