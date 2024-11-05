function P = params(freq)
%constants
P.mu = 4*pi*10.^-7;
P.epsilon_0 = 8.854e-12;
P.tanp = 2.2e-3;
P.epsilon_d = 2.55*P.epsilon_0*(1-1j*P.tanp);
P.eta_0 = sqrt(P.mu/P.epsilon_0);

%geometric parameters
P.a = 250e-3;
P.b = 253.048e-3;
P.z1 = -36.59e-3;
P.z2 = 36.59e-3;
P.phi1 = -6.8182 * pi/180;
P.phi2 = 6.8182 * pi/180;

P.z_1a = -23.68e-3;
P.z_2a = 23.68e-3;
P.phi_1a = 0 * pi/180;
P.phi_2a = 10.9435 * pi/180;

P.z_f = 6.05e-3;
P.phif = 0;
P.W_f = 4.e-3;%rLphif
P.dphif = 2*P.W_f/(P.a+P.b);
P.phi_1f = P.phif - P.dphif/2;
P.phi_2f = P.phif + P.dphif/2;

%source parameters
P.omega = freq*2*pi;
P.I0 = 1;

%aliases
P.L = P.z2 - P.z1;
P.delta_phi = P.phi2 - P.phi1;
P.delta_phia = P.phi_2a - P.phi_1a;
P.delta_phi_f = P.phi_2f - P.phi_1f;
P.kd = P.omega*sqrt(P.mu*P.epsilon_d);
P.k0 = P.omega*sqrt(P.mu*P.epsilon_0);

%other parameters
P.argmax = 400;
P.expmin = 200;
P.gamma = 1.781072418;
P.alpha = 0.5;

%precision parameters
P.Mmax = 1;
P.Pmax = 18;
P.nMax = 50;
P.qMax = 50;
P.Nkz = 50;
