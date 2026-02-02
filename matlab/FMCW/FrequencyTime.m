close all

fs = 1e6;               % Sample rate
T_chirp = 1e-3;         % Chirp duration
B = 150e3;              % Bandwidth
fc = 77e9;              % Center frequency
c = 3e8;                % Speed of light
lambda = c/fc;

% Target properties
R = 200;                % Range (meters)
v = 20;                 % Velocity (m/s)

% Time vectors
t = 0:1/fs:T_chirp;     % Fast time (within one chirp)
num_chirps = 32;        % Number of chirps for Doppler
slope = B / T_chirp;

% Visualize Frequency vs Time
f_tx = slope * t;                               % Transmitted frequency sweep
td = 2 * R / c;                                 % Time delay
f_rx = slope * (t - td);                        % Received frequency sweep (delayed)

figure(1);
plot(t*1e3, f_tx/1e3, 'b', 'LineWidth', 2); hold on;
plot(t*1e3, f_rx/1e3, 'r--', 'LineWidth', 2);
xlabel('Time (ms)'); ylabel('Frequency (kHz)');
legend('TX Signal', 'RX Signal'); title('Frequency vs Time (Sawtooth)');
grid on;