clear
close all 
clc

%% 27 gennaio 2025
% Versione finale dell'implementazione del Weighted Centroid Localization
% algorithm.
% In questo script vengono plottati la cdf calcolata sull'errore e 
% sull'errore quadratico.

%% SIMULAZIONE MSE (a)

cicli = 1000;
lambda = 0.12;

    %% PARAMETRI simulazione a.1
        
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 0; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.1
    
    SE1 = zeros(1, cicli);
    E1 = zeros(1, cicli);
    [SE1, ~, E1, ~] = wclfunc_v3(lambda, R, a, b, sigma_sdB, cicli);

    %% PARAMETRI simulazione a.2
        
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 6; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.2
    
    SE2 = zeros(1, cicli);
    E2 = zeros(1, cicli);
    [SE2, ~, E2, ~] = wclfunc_v3(lambda, R, a, b, sigma_sdB, cicli);

    %% PARAMETRI simulazione a.3
        
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 3; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.3
    
    SE3 = zeros(1, cicli);
    E3 = zeros(1, cicli);
    [SE3, ~, E3, ~] = wclfunc_v3(lambda, R, a, b, sigma_sdB, cicli);

    %% PARAMETRI simulazione a.4
        
    R = 200;       % raggio della circonferenza dell'area considerata.
    a = 2;         % esponente di path-loss.
    b = 0.8;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    sigma_sdB = 4; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).

    %% MSE simulazione a.4
    
    SE4 = zeros(1, cicli);
    E4 = zeros(1, cicli);
    [SE4, ~, E4, ~] = wclfunc_v3(lambda, R, a, b, sigma_sdB, cicli);

    %% PLOT CDF i-esime calcolate su SE
    
    figure;
    hold on;
    xlim([0, 4]);

    PLOT1 = cdfplot(SE1);
    PLOT1.Color = [0.8, 0.0, 0.0];
    PLOT1.LineWidth = 2;
    PLOT1.LineStyle = ':';

    PLOT3 = cdfplot(SE3);
    PLOT3.Color = [0 0.4470 0.7410];
    PLOT3.LineWidth = 2;
    PLOT3.LineStyle = ':';

    PLOT4 = cdfplot(SE4);
    PLOT4.Color = [0, 0.5, 0];
    PLOT4.LineWidth = 2;
    PLOT4.LineStyle = ':';

    PLOT2 = cdfplot(SE2);
    PLOT2.Color = [0.9290, 0.6940, 0.1250];
    PLOT2.LineWidth = 2;
    PLOT2.LineStyle = ':';
    
    xlabel('\xi^2 [m^2]');
    ylabel('F_{\xi^2}');
    legend('\fontsize{12}\sigma_{s, dB} = 0', '\fontsize{12}\sigma_{s, dB} = 3', ...
        '\fontsize{12}\sigma_{s, dB} = 4', '\fontsize{12}\sigma_{s, dB} = 6', 'Location','southeast');
    %'\fontsize{12}\sigma_{s, dB} = 2',%
    %title('CDF dell''errore quadratico per \alpha = 2, \beta = 0.8 e \lambda = 0.12 AP/m^2');
    title('');
    print(gcf,'CDFSE.eps','-deps');
    hold off;

    %% PLOT CDF i-esime calcolate sul E
    
    figure;
    hold on;
    xlim([-2, 2]);

    PLOT1 = cdfplot(E1);
    PLOT1.Color = [0.8, 0.0, 0.0];
    PLOT1.LineWidth = 2;
    PLOT1.LineStyle = ':';

    PLOT3 = cdfplot(E3);
    PLOT3.Color = [0 0.4470 0.7410];
    PLOT3.LineWidth = 2;
    PLOT3.LineStyle = ':';

    PLOT4 = cdfplot(E4);
    PLOT4.Color = [0, 0.5, 0];
    PLOT4.LineWidth = 2;
    PLOT4.LineStyle = ':';
    

    PLOT2 = cdfplot(E2);
    PLOT2.Color = [0.9290, 0.6940, 0.1250];
    PLOT2.LineWidth = 2;
    PLOT2.LineStyle = ':';

    xlabel('\xi [m]');
    ylabel('F_{\xi}');
    legend('\fontsize{12}\sigma_{s, dB} = 0', '\fontsize{12}\sigma_{s, dB} = 3', ...
        '\fontsize{12}\sigma_{s, dB} = 4', '\fontsize{12}\sigma_{s, dB} = 6', 'Location','southeast');
    %'\fontsize{12}\sigma_{s, dB} = 2',%    
    %title('CDF dell''errore per \alpha = 2, \beta = 0.8 e \lambda = 0.12 AP/m^2');
    title('');
    print(gcf,'CDFE.eps','-deps');
    hold off;