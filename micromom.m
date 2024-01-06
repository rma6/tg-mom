% clear;

% pool = gcp();
% queue = parallel.pool.DataQueue();
% afterEach(queue, @disp);
% 
% P=params();
% 
% %frequency space
% %freqs = linspace(2.3,2.5,80)*10^9;
% freqs=[2.42]*10^9;
% freqs_ghz = freqs/10^9;
% 
% for it = 1:size(freqs, 2)
%     Zs(it) = buildZMat(params(freqs(it)), queue);
% end

[~, freq_index] = findpeaks(real(zin));
peak_freq = freqs(freq_index);
peak_dMat = Ds{freq_index};
radpat(peak_dMat, params(peak_freq))