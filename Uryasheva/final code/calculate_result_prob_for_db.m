function result_db_prob = calculate_result_prob_for_db(root_prob, probabilities, dif_prob, Z)
result_db_prob = [];
for i = 1:size(Z, 1)
    prob_res_im = 0;
    out = [];
    for j = 1:size(Z, 2)
        %disp(probabilities(j,1));
        multipl_prob = 1.0;
        multipl_prob_log = 0;
        if ~isnan(probabilities(j,1))
            multipl_prob = probabilities(j, 1)*(1-dif_prob(i, j))+probabilities(j, 2)*dif_prob(i, j);
            if multipl_prob == 0
                multipl_prob_log = 1;
            else
                multipl_prob_log = log10(multipl_prob);
            end
        end
        out(end+1) = multipl_prob_log;
        prob_res_im = prob_res_im + multipl_prob_log;
    end
    %mean(out)
    %disp(prob_res_im);
    result_db_prob = [result_db_prob; prob_res_im];
end
end