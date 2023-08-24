clear;

P=params();

%sets up multithreading
pool = gcp();
q = parallel.pool.DataQueue();
afterEach(q, @disp);

%frequency space
%freqs = linspace(2.3,2.5,80)*10^9;
freqs=[2.42, 2.43, 2.44]*10^9;
freqs_ghz = freqs/10^9;

%starts jobs
fprintf("Total number of jobs: %i\n", size(freqs, 2)*2)
for it = 1:size(freqs, 2)
    Zjobs(it) = parfeval(pool, @buildZMat, 1, params(freqs(it)), q);
    Vjobs(it) = parfeval(pool, @buildVMat, 1, params(freqs(it)), q);
end

%colects jobs results
Zs = fetchOutputs(Zjobs);
Vs = fetchOutputs(Vjobs);

%calculates D matrix and input impedance
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

%plots results
plot(freqs_ghz, real(zin), 'color', '#0072BD')
hold on
plot(freqs_ghz, imag(zin), 'color', "#D95319")
hold on
title("Z_{in}")
legend("Re", "Im")
xlabel('GHz')
ylabel('\Omega')
xlim([freqs_ghz(1) freqs_ghz(end)])
ylim([-40 70])
grid on