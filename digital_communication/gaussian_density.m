%FEI - ELECTRICAL ENGINEERING
%NEC120 - DIGITAL COMMUNICATION
%DANILO H B SANTOS

function gaussian_density(m, s2)

    x = linspace(m - 3*sqrt(s2), m + 3*sqrt(s2), 1000); % Generates values for x
    y = (1/(sqrt(2*pi*s2))) * exp(-(x-m).^2/(2*s2)); % Calculates the probability density
   
    % Plots the graph
    figure;
    plot(x, y, 'LineWidth', 2);
    title('Gaussian Probability Density');
    xlabel('x');
    ylabel('Probability Density');
    grid on;
    
end
