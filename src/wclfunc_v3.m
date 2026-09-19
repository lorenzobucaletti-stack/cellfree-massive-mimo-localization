function [SE, MSE, E, ME] = wclfunc_v3(lambda, R, a, b, sigma_sdB, cicli)
%WCL funzione corrispondente allo script BucalettiLorenzo_WCL_v3.m
    % In ingresso accetta in ordine: la densità [APs/m^2] di AP effettivi,
    % il raggio della circonferenza dell'area considerata, l'esponente di
    % path-loss, il peso per le potenze ricevute, l'intensità di shadowing
    % e il numero di cicli da eseguire.
    % Restituisce SE, MSE, E e ME.

    % NOTA: a differenza del corrispettivo script, qui si fanno uso di
    % coordinate polari e non cartesiane; il motivo è spiegato a seguire.

    % Aggiornamento (14/01/2025): il numero di AP viene calcolato non in modo
    % deterministico ma attraverso una v.a. di Poisson.
    
    %% PARAMETRI
    
    % lambda = 0.02; densità [APs/m^2] di AP effettivi, cioè all'interno della circonferenza di raggio R, richiesta.
    % R = 200;       % raggio della circonferenza dell'area considerata.
    P_tdBm = 20;   % potenza trasmessa dal singolo AP in [dBm].
    % a = 2;         % esponente di path-loss.
    L0_dB = 48;    % valore del path-loss in [dB] ad una distanza di riferimento di 1 m.
    % b = 0.5;       % esponente che va a pesare le potenze ricevute i-esime, P_r(i).
    % sigma_sdB = 2; % intensità di shadowing in [dB] (valori tipici: 0, 1, 2, 3, 4).
    P_thdBm = -60; % soglia in [dBm] da superare della potenza ricevuta dei vari AP dall'utente affinché vengano considerati.
    %cicli = 500;   % numero di cicli eseguiti nel ciclo montecarlo.
    
    %% CICLO MONTECARLO
    
    SE = zeros(1, cicli); % prealloco la memoria per il vettore contenente gli errori quadratici di ogni ciclo.
    E = zeros(1, cicli); % prealloco la memoria per il vettore contenente gli errori di ogni ciclo.
    
    for i = 1:cicli
    
        %% CREAZIONE DELLA RETE
        
        N_AP = poissrnd(round(lambda*pi*(R^2))); % numero di AP effettivi, cioè all'interno della circonferenza di raggio R, richiesti.
        % NOTA: la funzione round() serve per arrotondare all'intero più vicino.
        
        % SOLUZIONE ALTERNATIVA (rispetto al corrispettivo script)
        % Questa soluzione evita i meccanicismi presenti nello script
        % BucalettiLorenzo_WCL_v3.m, alleggerendo e velocizzando la
        % simulazione grazie all'utilizzo delle coordinate polari: in
        % questo modo gli AP vengono generati direttamente all'interno
        % della circonferenza, facilitando la correlazione fra densità di
        % AP e la generazione delle posizioni di tali AP.
        r_AP = R * sqrt(rand(1, N_AP));  % Vettore contenente i moduli dei vettori che puntano ai diversi AP.
        theta = 2 * pi * rand(1, N_AP);  % Vettore contenente gli angoli dei vettori che puntano ai diversi AP.
        x_AP = r_AP .* cos(theta);  % Calcolo della coordinata x.
        y_AP = r_AP .* sin(theta);  % Calcolo della coordinata y.
       
        %% CALCOLO DELLA POTENZA RICEVUTA DALL'UTENTE
        
        sigma_s = sigma_sdB*log(10)/10; % intensità di shadowing in lineare.
        g_i = randn(1, N_AP); % esponente di shadowing per l'AP effettivo i-esimo.
        phi_i = exp(sigma_s*g_i); % fattore di shadowing l'AP effettivo i-esimo.
        
        P_t = 10^(P_tdBm/10)*(10^-3); % potenza trasmessa dal singolo AP in [W].
        L0 = 10^(L0_dB/10); % valore del path-loss in lineare ad una distanza di riferimento di 1 m.
        P_r = P_t*phi_i./(L0.*(1 + r_AP.^a)); % potenza dell'AP i-esimo ricevuta dall'utente in [W].
        
        %% CALCOLO DEI PESI
        
        w = P_r.^b; % peso della potenza dell'AP i-esimo ricevuta dall'utente.
        
        %% CALCOLO DELLA POSIZIONE STIMATA
        
        % NOTA: l'esclusione o meno di un AP sulla base della sua potenza ricevuta
        % dall'utente può essere implementata in due modi:
        %   1) Rimuovendo dal vettore dei pesi e delle posizioni gli AP la cui
        %   potenza non supera la soglia richiesta (soluzione più intuitiva, ma
        %   più difficile da implementare e differente da quella "analitica
        %   adottata nell'articolo).
        %   2) Utilizzando "e" per annullare il contributo dei pesi e della
        %   posizione di quei AP la cui potenza non supera la soglia richiesta
        %   (soluzione meno intuitiva, ma più facile da implementare e uguale a
        %   quella "analitica" adottata nell'articolo
        
        P_th = 10^(P_thdBm/10)*(10^-3); % soglia della potenza ricevuta in lineare
        NUM_x = 0;
        NUM_y = 0;
        DEN = 0;
        
        while true
            for j = 1:N_AP
                e = 1; % probabilità che l'AP i-esimo venga attivato.
                % Soluzione (2)
                if P_r(j) < P_th
                    e = 0;
                end
                % Calcolo della sommatoria a nominatore e a denominatore.
                NUM_x = NUM_x + w(j)*x_AP(j)*e;
                NUM_y = NUM_y + w(j)*y_AP(j)*e;
                DEN = DEN + w(j)*e;
            end
            % Soluzione al problema descritto nell'osservazione (6).
            if NUM_x == 0 || NUM_y == 0 || DEN == 0
                disp('Nessun AP è stato attivato');
                SE(i) = mean(SE(1:i-1)); % in questo caso pongo un SE fittizio uguale alla media dei SE precedenti.
                E(i) = mean(E(1:i-1)); % in questo caso pongo un E fittizio uguale alla media dei E precedenti.
            else
                break;
            end
        end
        x_u = NUM_x/DEN;
        y_u = NUM_y/DEN;
        
        %% CALCOLO DELL'ERRORE QUADRATICO (SE) E DELL'ERRORE (E)
        
        x_ureal = 0; % posizione reale lungo le ascisse dell'utente.
        y_ureal = 0; % posizione reale lungo le ordinate dell'utente.
        if SE(i) == 0 % controllo di non aver già calcolato SE(i).
            SE(i) = (x_u - x_ureal)^2 + (y_u - y_ureal)^2; % calcolo dell'errore quadratico per ogni ciclo.
            E(i) = (x_u - x_ureal) + (y_u - y_ureal); % calcolo dell'errore per ogni ciclo.
        end
    
    
    end % fine del ciclo
    
    %% CALCOLO DEL MSE (mean square error) e DEL ME (mean error)
    
    MSE = mean(SE);
    ME = mean(E);
end