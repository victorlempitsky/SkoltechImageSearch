%calculating probabilitites
function [probabilities, root_prob] = calculate_probabilities(Z, pa, Z_test, prior)
probabilities = [];
num_of_root = 0;
%for k=1:size(Z, 1)
for j=1:size(Z_test, 2)
    parent = pa(j);
    conditional_probability_beta = 0;
    coniditional_probability_alpha = 0;
    if parent~=0
        value_child = Z_test(:, j);
        value_parent = Z_test(:, parent);
        num_of_all_this = 0;
        num_of_all_not_this = 0;
        num_of_conseq = 0;
        num_of_not_conseq = 0;
        for k=1:size(Z, 1)
            if Z(k, j)==value_child
                if Z(k, parent)==value_parent
                     num_of_conseq = num_of_conseq+1;
                end
            else
                if Z(k, parent)==value_parent
                     num_of_not_conseq=num_of_not_conseq+1;
                end
            end
            if Z(k, parent) == value_parent
                num_of_all_this = num_of_all_this+1;
            end
        end
        conditional_probability_beta = num_of_conseq/num_of_all_this; %check it's double actually
        coniditional_probability_alpha = num_of_not_conseq/num_of_all_this;
    else
        num_of_root = j;
    end
    
    alpha_0 = 0.0;
    beta_0 = 0.0;
    alpha_1 = 0.0;
    beta_1 = 0.0;
    s_e_q = 0;
    if Z_test(:, j) == 0
        detect_prob_b = 0.9;
        detect_prob_a = 0.1;
%         disp('Z = 0');
%         disp('for s_e_q = 0');
%         disp([prior(j, 1) detect_prob_a coniditional_probability_alpha]);
        alpha_0 = prior(j, 1)*detect_prob_a*coniditional_probability_alpha;
        beta_0 = prior(j, 2)*detect_prob_b*conditional_probability_beta;
    else
        detect_prob_b = 0.1;
        detect_prob_a = 0.9;
%         disp('Z = 1');
%         disp('for s_e_q = 0');
%         disp([prior(j, 2) detect_prob_a coniditional_probability_alpha]);
        alpha_0 = prior(j, 2)*detect_prob_a*coniditional_probability_alpha;
        beta_0 = prior(j, 1)*detect_prob_b*conditional_probability_beta;
    end
    prob_0 = (1+alpha_0/beta_0)^-1;
    
    s_e_q = 1;
    if Z_test(:, j) == 0
        detect_prob_b = 0.39;
        detec_prob_a = 0.61;
        alpha_1 = prior(j, 1)*detec_prob_a*coniditional_probability_alpha;
        beta_1 = prior(j, 2)*detect_prob_b*conditional_probability_beta;
    else
        detect_prob_b = 0.61;
        detec_prob_a = 0.39;
        alpha_1 = prior(j, 2)*detect_prob_a*coniditional_probability_alpha;
        beta_1 = prior(j, 1)*detect_prob_b*conditional_probability_beta;
    end
    prob_1 = (1+alpha_1/beta_1)^-1;
    
    tmp_pr = [prob_0 prob_1];
    probabilities = [probabilities; tmp_pr];
end

root_prob = 0.0;
for k=1:size(Z, 1)
    if Z(k, num_of_root)==Z_test(:, num_of_root)
        root_prob = root_prob+1;
    end
end
root_prob = root_prob/size(Z, 1);
%end
end