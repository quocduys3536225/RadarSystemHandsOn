close all

hases = zeros(1, num_chirps);
for m = 1:num_chirps
    tm = (m-1) * T_chirp; % Slow time
    % Phase shift due to velocity: 2 * pi * fd * tm
    fd = 2 * v / lambda;
    phases(m) = angle(exp(1j * 2 * pi * fd * tm));
end

figure(3);
stem(1:num_chirps, phases);
xlabel('Chirp Number'); ylabel('Phase (radians)');
title('Phase Shift Across Chirps (Velocity Indicator)');