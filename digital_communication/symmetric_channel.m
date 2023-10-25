%FEI - ELECTRICAL ENGINEERING
%NEC120 - DIGITAL COMMUNICATION
%DANILO H B SANTOS

function pk = symmetric_channel()

    % Requests the values of n, pe and k from the user
    n = input('Enter the total number of digits (n): ');
    pe = input('Enter the channel error probability (pe): ');
    k = input('Enter the maximum number of digits in error desired (k): ');

    % Calculates pk using the cumulative binomial distribution formula
    pk = 0;
    for i = 1:k
        pk = pk + nchoosek(n, i) * pe^i * (1 - pe)^(n - i);
    end

    % Displays the result
    disp(['The probability of receiving up to ', num2str(k), ' digits in error is ', num2str(pk)]);

end
