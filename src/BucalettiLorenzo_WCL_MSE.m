clear
close all 
clc

%% 27 gennaio 2025
% Versione finale dell'implementazione del Weighted Centroid Localization
% algorithm.
% In questo script vengono plottati i valori del MSE al variare della
% densità "lambda".

%% SIMULAZIONE MSE (a)

cicli = 1000;
lambda = 0.02:0.01:0.12; % densità [APs/m^2] di AP effettivi, cioè all'interno della circonferenza di raggio R, richiesta.
    
    %% PARAMETRI simulazione a.1
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 0; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.1
    
    MSE1 = zeros(1, length(lambda));
    for i = 1:length(lambda)
        [~, MSE1(i), ~, ~] = wclfunc_v3(lambda(i), R, a, b, sigma_sdB, cicli);
    end

    %% PARAMETRI simulazione a.2
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 2; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.2
    
    MSE2 = zeros(1, length(lambda));
    for i = 1:length(lambda)
        [~, MSE2(i), ~, ~] = wclfunc_v3(lambda(i), R, a, b, sigma_sdB, cicli);
    end

    %% PARAMETRI simulazione a.3
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 3; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.3
    
    MSE3 = zeros(1, length(lambda));
    for i = 1:length(lambda)
        [~, MSE3(i), ~, ~] = wclfunc_v3(lambda(i), R, a, b, sigma_sdB, cicli);
    end

    %% PARAMETRI simulazione a.4
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 4; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.4
    
    MSE4 = zeros(1, length(lambda));
    for i = 1:length(lambda)
        [~, MSE4(i), ~, ~] = wclfunc_v3(lambda(i), R, a, b, sigma_sdB, cicli);
    end

    %% PARAMETRI simulazione a.5
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 6; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.5
    
    MSE5 = zeros(1, length(lambda));
    for i = 1:length(lambda)
        [~, MSE5(i), ~, ~] = wclfunc_v3(lambda(i), R, a, b, sigma_sdB, cicli);
    end

    %% PLOT MSE i-esimi al variare di lambda
    
    figure;
    hold on;
    grid on;
    
    plot(lambda, MSE1, '-square', 'Color', [0.8, 0.0, 0.0], 'LineWidth', 2);           % plotting del MSE della simulazione a.1.
    plot(lambda, MSE2, '-square', 'Color', [0, 0.5, 0], 'LineWidth', 2);               % plotting del MSE della simulazione a.2.
    plot(lambda, MSE3, '-square', 'Color', [0 0.4470 0.7410], 'LineWidth', 2);         % plotting del MSE della simulazione a.3.
    plot(lambda, MSE4, '-square', 'Color', [0.9290, 0.6940, 0.1250],  'LineWidth', 2); % plotting del MSE della simulazione a.4.
    plot(lambda, MSE5, '-square', 'Color', [0.9, 0.4, 0],  'LineWidth', 2);              % plotting del MSE della simulazione a.5.


    xlabel('\lambda [APs/m^2]');
    ylabel('MSE [m^2]');
    %title('MSE per \alpha = 2 e \beta = 0.8')
    legend('\fontsize{12}\sigma_{s, dB} = 0', '\fontsize{12}\sigma_{s, dB} = 2', ...
        '\fontsize{12}\sigma_{s, dB} = 3', '\fontsize{12}\sigma_{s, dB} = 4', ...
        '\fontsize{12}\sigma_{s, dB} = 6');
    hold off;
    