%calculating prior probabilitites
%in prior we have only one image (one image = one location)
function prior_prob = calculate_prior_probabilities(Z)
num_of_all = size(Z, 1);
prior_prob = [];
%values = [0, 1];
for i=1:size(Z, 2)
    num_of_zeros = 0;
    num_of_ones = 0;
    for j=1:size(Z, 1)
        if Z(j, i)==0
            num_of_zeros=num_of_zeros+1;
        else
            num_of_ones = num_of_ones+1;
        end
    end
    prob_zero = num_of_zeros/num_of_all; %check if not int
    prob_one = num_of_ones/num_of_all;
    prob = [prob_zero, prob_one];
    prior_prob = [prior_prob; prob];
end
end