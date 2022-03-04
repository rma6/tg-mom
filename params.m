function P = params()

%constants
P.mu = 4*pi*10.^-7;
P.epsilon_0 = 8.85e-12;
P.epsilon_d = 2.55*P.epsilon_0;%*(1-1j*tan(2.2e-3));

%geometric parameters
P.z1 = 0; %ok
P.z2 = 59.45e-3; %ok
P.a = 250e-3; %ok
P.b = 253.048e-3; %ok
P.phi1 = -10 * pi/180; %ok
P.phi2 = 20.9435 * pi/180; %ok
P.phi_1a = 0 * pi/180; %ok
P.phi_2a = 10.9435 * pi/180; %ok
P.phi_1f = 4.013411 * pi/180; %ok
P.phi_2f = 4.9245889 * pi/180; %ok
P.z_f = 28.87e-3; %ok

%source parameters
P.omega = 2.45e9*2*pi;
P.I0 = 1;

%aliases
P.L = P.z2 - P.z1;
P.delta_phi = P.phi2 - P.phi1;
P.delta_phia = P.phi_2a - P.phi_1a;
P.delta_phi_f = P.phi_2f - P.phi_1f;
P.kd = P.omega*sqrt(P.mu*P.epsilon_d);
P.k0 = P.omega*sqrt(P.mu*P.epsilon_0);

%theta parameters
P.argmax = 400;
P.expmin = 200;
P.gamma = 1.781072418;

%iteration parameters
P.Mmax = 4;
P.Pmax = 1;
P.Mspace = linspace(P.phi1, P.phi2, P.Mmax+1);
P.its.z_in_f.n = 100;
P.its.z_in_f.q = 100;
P.its.Hz_in_proj = 100;
P.its.Hz_out_proj.n = 100;
P.its.Hz_out_proj.kz = 100*P.k0;
P.its.V.n = 30;

%ploting

%log
P.log.all = false;