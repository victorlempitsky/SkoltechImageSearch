function dif_prob = calculate_dif_prob(Z)
dif_prob = [];
for i=1:size(Z,1)
    row_z = [];
    for j=1:size(Z,2)
        if Z(i,j)==0
            row_z = [row_z 0.05];
        else
            row_z = [row_z 0.95];
        end
    end
    dif_prob = [dif_prob; row_z];
end
end