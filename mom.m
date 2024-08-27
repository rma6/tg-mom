%mpiprofile on
close 'all'
clear;
tstamp = datetime(now,'ConvertFrom','datenum');
tstamp = strrep(string(tstamp),':','-');
tfolder = sprintf("data/%s", tstamp);
mkdir(tfolder)
diary(fullfile(tfolder, "log.txt"))

P=params();

%sets up multithreading
pool = gcp();
queue = parallel.pool.DataQueue();
afterEach(queue, @disp);

%frequency space
freqs = linspace(2.2,2.6,401)*10^9;
%freqs=[2.43]*10^9;
freqs_ghz = freqs/10^9;

%starts jobs
fprintf("Total number of jobs: %i\n", size(freqs, 2)*2)
for it = 1:size(freqs, 2)
    Zjobs(it) = parfeval(pool, @buildZMat, 1, params(freqs(it)), queue);
    Vjobs(it) = parfeval(pool, @buildVMat, 1, params(freqs(it)), queue);
end

%colects jobs results
Zs = fetchOutputs(Zjobs);
Vs = fetchOutputs(Vjobs);

% %calculates D matrix and input impedance
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

[~, freq_index] = findpeaks(real(zin));
peak_freq = freqs(freq_index);
peak_dMat = Ds{freq_index};
radpat(peak_dMat, params(peak_freq))

%plots results
figure("Name", "zin")
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

%save data
save(fullfile(tfolder, "workspace.mat"))

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = get(FigHandle, 'Name');
  savefig(FigHandle, fullfile(sprintf("data/%s", tstamp), FigName, '.fig'));
end

diary off
beep
%mpiprofile viewer