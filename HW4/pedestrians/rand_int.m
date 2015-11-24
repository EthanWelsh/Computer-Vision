function [ r ] = rand_int(a, b)
    r = round(a + (b-a).*rand(1));
end

