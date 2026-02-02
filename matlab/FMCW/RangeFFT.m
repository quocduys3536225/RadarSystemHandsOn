close all

tx_sig = exp(1j * pi * slope * t.^2);
rx_sig = exp(1j * pi * slope * (t - td).^2);
beat_sig = tx_sig .* conj(rx_sig); % Mixing

% FFT to find Range
Nfft = 1024;
X = fft(beat_sig, Nfft);
f_axis = (0:Nfft-1) * (fs / Nfft);
range_axis = f_axis * c / (2 * slope);

figure(2);
plot(range_axis, abs(X));
xlabel('Range (m)'); ylabel('Magnitude');
title('Range Profile (Beat Frequency Peak)');
xlim([0 400]); % Look around our 200m target