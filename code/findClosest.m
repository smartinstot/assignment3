function [index] = findClosest(A,B)
%FINDCLOSEST Returns the index of the cloest element of B for each A
%   Detailed explanation goes here
    index = zeros(length(A), 1);
    for i=1:length(A)
        [~, temp] = min(abs(B-A(i)));
        index(i) = temp;
    end
end

