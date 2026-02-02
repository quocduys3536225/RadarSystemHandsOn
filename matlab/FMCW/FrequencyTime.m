close all
clear; clc;

% --- Radar Parameters ---
fs = 1e6;               % Sample rate (Hz)
T_chirp = 2e-3;         % Chirp duration (1 ms)
B = 150e3;              % Bandwidth (150 kHz) 
fc = 77e9;              % Center frequency (77 GHz)
c = 3e8;                % Speed of light (m/s)
lambda = c/fc;

% --- Target Properties ---
R = 200;                % Range (meters)
v = 20;                 % Velocity (m/s)

% --- Derived Parameters ---
slope = B / T_chirp;    % Slope of the ramp
td = 2 * R / c;         % Round trip delay time

% ==========================================
% FIGURE 1: Single Chirp (Zoomed View)
% ==========================================
t = 0:1/fs:T_chirp;     % Fast time (one chirp)

% Generate One Chirp
f_tx = slope * t;           
f_rx = slope * (t - td); 
% Mask out negative frequencies for Rx (physically Rx starts after td)
f_rx(t < td) = NaN; 

figure(1);
plot(t*1e3, f_tx/1e3, 'b', 'LineWidth', 2); hold on;
plot(t*1e3, f_rx/1e3, 'r--', 'LineWidth', 2);
xlabel('Time (ms)'); ylabel('Frequency (kHz)');
legend('TX Signal', 'RX Signal'); 
title('Figure 1: Single Chirp Zoom');
grid on;

% ==========================================
% FIGURE 2: Multiple Chirps (50ms Train)
% ==========================================
T_total = 50e-3;        % 50 ms duration
t_long = 0:1/fs:T_total; % Long time vector

% 1. Create the repeating Sawtooth pattern using mod()
% mod(t, T_chirp) resets time to 0 every T_chirp seconds
f_tx_train = slope * mod(t_long, T_chirp);

% 2. Create Rx Train (Delayed version of Tx)
% We calculate based on (t - td)
f_rx_train = slope * mod(t_long - td, T_chirp);

% Optional: Remove "flyback" lines for cleaner plotting
% When the chirp resets, the plot draws a vertical line. We can hide it by setting
% the last sample of each chirp to NaN.
reset_indices = find(diff(f_tx_train) < 0);
f_tx_train(reset_indices) = NaN;
f_rx_train(reset_indices) = NaN;

figure(2);
plot(t_long*1e3, f_tx_train/1e3, 'b', 'LineWidth', 1.5); hold on;
plot(t_long*1e3, f_rx_train/1e3, 'r--', 'LineWidth', 1.5);

xlabel('Time (ms)'); 
ylabel('Frequency (kHz)');
legend('TX Signal', 'RX Signal'); 
title('Figure 2: Chirp Sequence (50ms duration)');
grid on;
xlim([0 50]); % Limit x-axis to 50ms