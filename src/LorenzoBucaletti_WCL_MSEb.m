clear
close all 
clc

%% 27 gennaio 2025
% Versione finale dell'implementazione del Weighted Centroid Localization
% algorithm.
% In questo script vengono plottati i valori del MSE al variare del
% coefficiente di peso beta.

%% SIMULAZIONE MSE (a)

cicli = 1000;
lambda1 = 0.2; % densità [APs/m^2] di AP effettivi necessari per plottare il MSE al variare di b.
lambda2 = 0.12;
b = 0.5:0.1:1.2; % esponente che va a pesare le potenze ricevute i-esime, P_r(i).

    %% PARAMETRI simulazione a.1
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    sigma_sdB = 0; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.1

    MSE11 = zeros(1, length(b));
    MSE12 = zeros(1, length(b));
    for i = 1:length(b)
        [~, MSE11(i), ~, ~] = wclfunc_v3(lambda1, R, a, b(i), sigma_sdB, cicli);
        [~, MSE12(i), ~, ~] = wclfunc_v3(lambda2, R, a, b(i), sigma_sdB, cicli);
    end

    %% PARAMETRI simulazione a.2
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    sigma_sdB = 1; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.2

    MSE21 = zeros(1, length(b));
    MSE22 = zeros(1, length(b));
    for i = 1:length(b)
        [~, MSE21(i), ~, ~] = wclfunc_v3(lambda1, R, a, b(i), sigma_sdB, cicli);
        [~, MSE22(i), ~, ~] = wclfunc_v3(lambda2, R, a, b(i), sigma_sdB, cicli);
    end

    %% PARAMETRI simulazione a.3
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    sigma_sdB = 2; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.3

    MSE31 = zeros(1, length(b));
    MSE32 = zeros(1, length(b));
    for i = 1:length(b)
        [~, MSE31(i), ~, ~] = wclfunc_v3(lambda1, R, a, b(i), sigma_sdB, cicli);
        [~, MSE32(i), ~, ~] = wclfunc_v3(lambda2, R, a, b(i), sigma_sdB, cicli);
    end

    %% PARAMETRI simulazione a.4
    
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    sigma_sdB = 3; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.4

    MSE41 = zeros(1, length(b));
    MSE42 = zeros(1, length(b));
    for i = 1:length(b)
        [~, MSE41(i), ~, ~] = wclfunc_v3(lambda1, R, a, b(i), sigma_sdB, cicli);
        [~, MSE42(i), ~, ~] = wclfunc_v3(lambda2, R, a, b(i), sigma_sdB, cicli);
    end

    %% PLOT MSE i-esimi al variare di beta (lambda = 0.2)
    
    figure;
    hold on;
    
    plot(b, MSE11, '-square', 'Color', [0.8, 0.0, 0.0], 'LineWidth', 2);           % plotting del MSE della simulazione a.1.
    plot(b, MSE21, '-square', 'Color', [0.9290, 0.6940, 0.1250], 'LineWidth', 2);               % plotting del MSE della simulazione a.2.
    plot(b, MSE31, '-square', 'Color', [0, 0.5, 0], 'LineWidth', 2);         % plotting del MSE della simulazione a.3.
    plot(b, MSE41, '-square', 'Color', [0 0.4470 0.7410],  'LineWidth', 2); % plotting del MSE della simulazione a.4.

    xlabel('\beta');
    ylabel('MSE [m^2]');
    title('MSE per \alpha = 2 e \lambda = 0.2 AP/m^2')
    legend('\fontsize{12}\sigma_{s, dB} = 0', '\fontsize{12}\sigma_{s, dB} = 1', ...
        '\fontsize{12}\sigma_{s, dB} = 2', '\fontsize{12}\sigma_{s, dB} = 3');
    print(gcf,'MSEbeta1.pdf','-dpdf','-r300');
    hold off;

    %% PLOT MSE i-esimi al variare di beta (lambda = 0.12)
    
    figure;
    hold on;
    
    plot(b, MSE12, '-square', 'Color', [0.8, 0.0, 0.0], 'LineWidth', 2);           % plotting del MSE della simulazione a.1.
    plot(b, MSE22, '-square', 'Color', [0.9290, 0.6940, 0.1250], 'LineWidth', 2);               % plotting del MSE della simulazione a.2.
    plot(b, MSE32, '-square', 'Color', [0, 0.5, 0], 'LineWidth', 2);         % plotting del MSE della simulazione a.3.
    plot(b, MSE42, '-square', 'Color', [0 0.4470 0.7410],  'LineWidth', 2); % plotting del MSE della simulazione a.4.

    xlabel('\beta');
    ylabel('MSE [m^2]');
    title('MSE per \alpha = 2 e \lambda = 0.12 AP/m^2')
    legend('\fontsize{12}\sigma_{s, dB} = 0', '\fontsize{12}\sigma_{s, dB} = 1', ...
        '\fontsize{12}\sigma_{s, dB} = 2', '\fontsize{12}\sigma_{s, dB} = 3');
    print(gcf,'MSEbeta2.pdf','-dpdf','-r300');
    hold off;