%FEI - ELECTRICAL ENGINEERING
%NEC120 - DIGITAL COMMUNICATION
%DANILO H B SANTOS

function avg = average_biterror()

    % Requests the values of n and pe from the user
    n = input('Enter the total number of digits (n): ');
    pe = input('Enter the channel error probability (pe): ');

    % Calculates AVG of bit error
    avg = 0;
    for i = 0:n
        avg = avg + i*[nchoosek(n, i) * pe^i * (1 - pe)^(n - i)];
    end
    % Displays the result
    disp(['The average value of receiving up to ', num2str(n), ' digits in error is ', num2str(avg)]);

end