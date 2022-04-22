clear;
pool = gcp();
q = parallel.pool.DataQueue();
afterEach(q, @disp);

freqs = (2.2:0.01:2.7)*10^9;

fprintf("Total number of jobs: %i\n", size(freqs, 2)*2)

for it = 1:size(freqs, 2)
    Zjobs(it) = parfeval(pool, @buildZMat, 1, params(freqs(it)), q);
    Vjobs(it) = parfeval(pool, @buildVMat, 1, params(freqs(it)), q);
end

Zs = fetchOutputs(Zjobs);
Vs = fetchOutputs(Vjobs);

Ds = cell(size(Zs));
zinf = zeros(1, size(Zs, 1));
zinm = zeros(1, size(Zs, 1));
zin = zeros(1, size(Zs, 1));
for it = 1:size(Zs, 1)
    Ds{it} = Zs{it}\Vs{it};
    zinf(it) = z_in_f(params(freqs(it)));
    zinm(it) = z_in_m(Ds{it}, Vs{it}, params(freqs(it)));
    zin(it) = zinf(it) + zinm(it);
end

plot(freqs, real(zin), freqs, imag(zin))