function Hearing_Model_Final
    % MAT263E PROJECT - Role 5: Hands-on Activity
    % Theme: Scientific Dark (Deep Navy & Pastel Accents)
    % Status: FIXED LAYOUT (No text overlapping) & Modern Colors

    % --- 1. DATASET (ISO 226:2003) ---
    freq_raw = [20; 25; 31.5; 40; 50; 63; 80; 100; 125; 160; 200; 250; 315; 400; ...
                500; 630; 800; 1000; 1250; 1600; 2000; 2500; 3150; 4000; 5000; ...
                6300; 8000; 10000; 12500];
    y_db = [78.1; 68.7; 59.5; 51.1; 44.0; 37.5; 31.5; 26.5; 22.1; 17.9; 14.4; ...
            11.4; 8.6; 6.2; 4.4; 3.0; 2.2; 2.4; 3.5; 1.7; -1.3; -4.2; -6.0; ...
            -5.4; -1.5; 6.0; 12.6; 13.9; 12.3];

    x_log = log10(freq_raw);
    playerObj = []; 

    % --- AESTHETIC COLOR PALETTE ---
    col.bg       = [0.10, 0.11, 0.14]; % Main Window Background
    col.panel    = [0.15, 0.16, 0.20]; % Control Panel Background
    col.axis_bg  = [0.08, 0.08, 0.10]; % Plot Area Background
    col.text     = [0.90, 0.90, 0.92]; % Off-white text
    col.grid     = [0.30, 0.30, 0.35]; % Subtle grid lines
    col.dots     = [1.00, 0.40, 0.40]; % Coral/Salmon (Raw Data)
    col.line     = [0.20, 0.80, 1.00]; % Electric Blue (Fit Line)
    col.good     = [0.30, 0.85, 0.50]; % Mint Green (Ideal)
    col.bad      = [1.00, 0.30, 0.30]; % Alert Red (Overfit)
    col.btn_play = [0.00, 0.60, 0.40]; % Calm Green Button
    col.btn_stop = [0.80, 0.20, 0.20]; % Stop Red Button

    % --- 2. UI CONSTRUCTION ---
    fig = uifigure('Name', 'Human Hearing Model - Interactive Lab', ...
        'Position', [100 100 1000 720], 'Color', col.bg);

    % Title Header
    uilabel(fig, 'Position', [50 660 900 40], ...
        'Text', 'Topic 12: Least Squares Modeling of Human Hearing', ...
        'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', ...
        'FontColor', col.line);

    % Axes (Graph Area)
    ax = uiaxes(fig, 'Position', [50 240 900 400]);
    title(ax, 'Model Fit vs. ISO 226 Data', 'Color', col.text, 'FontSize', 16);
    xlabel(ax, 'Frequency (Hz) - Log Scale', 'Color', [0.7 0.7 0.7]);
    ylabel(ax, 'Threshold (dB SPL)', 'Color', [0.7 0.7 0.7]);
    
    % Styling the Axes
    ax.BackgroundColor = col.axis_bg;
    ax.XColor = col.text; 
    ax.YColor = col.text;
    ax.GridColor = col.grid;
    ax.GridAlpha = 0.4;
    ax.Box = 'on';
    grid(ax, 'on'); 
    ax.FontSize = 12;
    ax.XScale = 'log'; 

    % --- CONTROL PANEL ---
    pnl = uipanel(fig, 'Position', [50 30 900 180], ...
        'Title', 'Control Panel', ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', col.panel, ...
        'ForegroundColor', col.text);

    % 1. SLIDER (YUKARI TAŞINDI - Y: 130)
    uilabel(pnl, 'Position', [30 120 150 20], ...
        'Text', 'Polynomial Degree:', ...
        'FontWeight', 'bold', 'FontColor', col.text);
    
    sld = uislider(pnl, ...
        'Position', [190 130 450 3], ... % Daha yukarı alındı
        'Limits', [1 12], ...
        'Value', 2, ...
        'MajorTicks', 1:12, ...
        'MinorTicks', [], ...
        'FontColor', col.text, ...
        'ValueChangedFcn', @(src, event) updateGraph(src, ax, x_log, freq_raw, y_db, col));

    % Dynamic Label (AŞAĞI İNDİRİLDİ - Y: 60)
    % Artık Slider'ın sayılarıyla çakışmayacak
    lblDegree = uilabel(pnl, 'Position', [190 60 450 30], ... 
        'Text', 'Degree: 2 (Parabola)', ...
        'HorizontalAlignment', 'center', 'FontSize', 18, ...
        'FontWeight', 'bold', 'FontColor', col.line);

    % 2. AUDIO BUTTON
    btnPlay = uibutton(pnl, 'push', ...
        'Position', [680 60 180 60], ...
        'Text', '🔊 Play Audio', ...
        'FontSize', 16, 'FontWeight', 'bold', ...
        'BackgroundColor', col.btn_play, ...
        'FontColor', 'white', ...
        'ButtonPushedFcn', @(btn,event) handleAudio(btn, fig, col));

    % 3. ERROR DISPLAY
    lblRMSE = uilabel(fig, 'Position', [730 590 180 30], ...
        'Text', 'RMSE: ...', ...
        'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.1 0.1 0.1 0.7], ...
        'FontColor', col.text, 'FontWeight', 'bold', 'FontSize', 14);

    % --- 3. INITIALIZATION ---
    updateGraph(sld, ax, x_log, freq_raw, y_db, col);


    % --- 4. CORE FUNCTIONS ---

    function updateGraph(slider, axes, x, x_real, y, colors)
        degree = round(slider.Value);
        slider.Value = degree; 
        
        % Feedback Logic
        if degree == 1
            txt = 'Degree: 1 (Underfitting)'; 
            c_stat = [1.0 0.6 0.2]; % Orange
        elseif degree >= 4 && degree <= 6
            txt = sprintf('Degree: %d (Ideal Model)', degree); 
            c_stat = colors.good;
        elseif degree > 9
            txt = sprintf('Degree: %d (OVERFITTING!)', degree); 
            c_stat = colors.bad;
        else
            txt = sprintf('Degree: %d', degree); 
            c_stat = colors.line;
        end
        lblDegree.Text = txt; 
        lblDegree.FontColor = c_stat;

        % Math Core
        n = length(x);
        A = zeros(n, degree + 1);
        for i = 0:degree; A(:, i+1) = x .^ i; end
        c = A \ y; 
        
        y_pred = A * c;
        rmse = sqrt(mean((y - y_pred).^2));
        lblRMSE.Text = sprintf('RMSE: %.2f dB', rmse);

        x_smooth = linspace(min(x), max(x), 500); 
        y_smooth = polyval(flipud(c), x_smooth);
        
        % PLOTTING (With Fix for Overlap)
        hold(axes, 'off'); 
        
        % 1. Fit Line (Bottom Layer)
        plot(axes, 10.^x_smooth, y_smooth, '-', ...
            'Color', colors.line, 'LineWidth', 2.5); 
        
        hold(axes, 'on'); 
        
        % 2. Data Points (Top Layer)
        plot(axes, x_real, y, 'o', 'MarkerSize', 7, ...
            'MarkerFaceColor', colors.dots, 'MarkerEdgeColor', 'white', ...
            'LineWidth', 0.8);
            
        hold(axes, 'off'); 
        
        legend(axes, 'Polynomial Model', 'ISO 226 Data', ...
            'Location', 'northeast', 'TextColor', [0.1 0.1 0.1]); 
        axes.XScale = 'log'; 
        axes.XLim = [min(x_real) max(x_real)];
        axes.YLim = [-15 90];
    end

    function handleAudio(btn, figureHandle, colors)
        if ~isempty(playerObj) && isplaying(playerObj)
            stop(playerObj); return;
        end

        selection = uiconfirm(figureHandle, ...
            'Select Frequency to Experience:', 'Audio Test', ...
            'Options', {'20 Hz (Deep Bass)', '1000 Hz (Reference)', '12500 Hz (High Treble)', 'Cancel'}, ...
            'DefaultOption', 2, 'CancelOption', 4);

        if strcmp(selection, 'Cancel'); return; end

        if contains(selection, '20 Hz'); f = 20; amp = 1.0; 
        elseif contains(selection, '1000 Hz'); f = 1000; amp = 0.1;
        else; f = 12500; amp = 0.5; end

        Fs = 44100; duration = 5; 
        t = 0:1/Fs:duration;
        y_sound = amp * sin(2*pi*f*t);
        
        playerObj = audioplayer(y_sound, Fs);
        playerObj.StopFcn = @(src, event) resetButton(btn, colors);
        
        play(playerObj);
        btn.Text = '🛑 STOP AUDIO';
        btn.BackgroundColor = colors.btn_stop;
    end

    function resetButton(btn, colors)
        btn.Text = '🔊 Play Audio';
        btn.BackgroundColor = colors.btn_play;
    end
end