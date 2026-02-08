% Radar Range Equation Simulation
clear; clc; close all;

%% 1. Define Radar Parameters (Constants)
Pt = 1e-3;          % Transmitted Power (1 mW) 
G_db = 15;          % Antenna Gain in dB 
G = 10^(G_db/10);   % Convert dB to Linear Gain
fc = 77e9;          % Operating Frequency (77 GHz for Automotive Radar)
c = 3e8;            % Speed of light (m/s)
lambda = c / fc;    % Wavelength (lambda) 
sigma = 1;         % Radar Cross Section (m^2)

%% 2. Define Range Vector
R = 1:1:200;        % Target distance from 1m to 200m 

%% 3. Calculate Received Power (Pr) using the derived formula [cite: 47, 134]
% Formula: Pr = (Pt * G^2 * sigma * lambda^2) / ((4*pi)^3 * R^4)
numerator = Pt * (G^2) * sigma * (lambda^2);
denominator = ((4 * pi)^3) .* (R.^4);
Pr = numerator ./ denominator;

%% 4. Visualization
figure;
semilogy(R, Pr, 'LineWidth', 2);
grid on;
title('Received Power vs. Target Range');
xlabel('Range (meters)');
ylabel('Received Power (Watts)');

%% 5. Calculate Maximum Range (Rmax)
Smin = 1e-12;       % Min detectable signal (e.g., -90 dBm or 1 pW)
sigma_range = 0.1:0.1:100; % Varying target size from a bird to a large truck

% Formula: Rmax = ((Pt * G^2 * sigma * lambda^2) / ((4*pi)^3 * Smin))^(1/4)
Rmax = ((Pt * G^2 .* sigma_range * lambda^2) / ((4 * pi)^3 * Smin)).^(1/4);

%% 6. Visualization for Rmax
figure;
plot(sigma_range, Rmax, 'r', 'LineWidth', 2);
grid on;
title('Maximum Detection Range vs. Target RCS (\sigma)');
xlabel('Target RCS (\sigma) [m^2]');
ylabel('Maximum Range (R_{max}) [meters]');