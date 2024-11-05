confs = [ % Mmax, Pmax, nMax, qMax, Nkz
1, 18, 50, 50, 50;
% 1, 18, 30, 50, 50;
% 1, 18, 40, 50, 50;
% 1, 18, 60, 50, 50;
% 1, 18, 70, 50, 50;
% 1, 18, 80, 50, 50;
% 1, 18, 90, 50, 50;
% 1, 18, 100, 50, 50;
% 1, 18, 50, 40, 50;
% 1, 18, 50, 60, 50;
% 1, 18, 50, 70, 50;
% 1, 18, 50, 50, 30;
% 1, 18, 50, 50, 40;
% 1, 18, 50, 50, 60;
];

for ci = 1:size(confs, 1)
    %mpiprofile on
    close 'all'
    clearvars -except confs ci;
    tstamp = datetime(now,'ConvertFrom','datenum');
    tstamp = strrep(string(tstamp),':','-');
    tfolder = sprintf("data/%s", tstamp);
    mkdir(tfolder)
    diary(fullfile(tfolder, "log.txt"))
    
    %; was omited for logging purposes
    P=params(2.4*10^9, confs(ci,1), confs(ci,2), confs(ci,3), confs(ci,4), confs(ci,5))
    P.its
    
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
        Zjobs(it) = parfeval(pool, @buildZMat, 1, params(freqs(it), confs(ci,1), confs(ci,2), confs(ci,3), confs(ci,4), confs(ci,5)), queue);
        Vjobs(it) = parfeval(pool, @buildVMat, 1, params(freqs(it), confs(ci,1), confs(ci,2), confs(ci,3), confs(ci,4), confs(ci,5)), queue);
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
        zinf(it) = z_in_f(params(freqs(it), confs(ci,1), confs(ci,2), confs(ci,3), confs(ci,4), confs(ci,5)));
        zinm(it) = z_in_m(Ds{it}, Vs{it}, params(freqs(it), confs(ci,1), confs(ci,2), confs(ci,3), confs(ci,4), confs(ci,5)));
        zin(it) = zinf(it) + zinm(it);
    end
    
    [~, freq_index] = findpeaks(real(zin));
    peak_freq = freqs(freq_index);
    if size(peak_freq, 2) > 1
        peak_freq = interp1(peak_freq,peak_freq,2.4e9,'nearest');
        freq_index = find(freqs == peak_freq);
    end
    peak_dMat = Ds{freq_index};
    peak_power = 0.5*real(zin(freq_index))*abs(P.I0)^2;
    [gain_phi0, gain_theta90] = radpat(peak_dMat, peak_power, params(peak_freq, confs(ci,1), confs(ci,2), confs(ci,3), confs(ci,4), confs(ci,5)));
    
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
      savefig(FigHandle, fullfile(sprintf("data/%s/%s.fig", tstamp, FigName)));
    end
    
    sprintf("finished MoM at %s", string(datetime))
    diary off
    beep
    %mpiprofile viewer
end