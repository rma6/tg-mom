clear;

pool = gcp();
q = parallel.pool.DataQueue();
afterEach(q, @disp);

P=params();

%frequency space
%freqs = linspace(2.3,2.5,80)*10^9;
freqs=[2.42, 2.43, 2.44]*10^9;
freqs_ghz = freqs/10^9;

for it = 1:size(freqs, 2)
    Vs(it) = buildVMat(params(freqs(it)), q);
end