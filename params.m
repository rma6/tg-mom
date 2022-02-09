function P = params()

%constants
P.mu = 4*pi*10.^-7;
P.epsilon_0 = 8.85e-12;
P.epsilon_d = 2.55*P.epsilon_0*(1-1j*tan(2.2e-3));

%geometric parameters
P.z1 = 0;
P.z2 = 59.45e-3;
P.a = 250e-3;
P.b = 253.048e-3;
P.phi1 = 10 * pi/180;
P.phi2 = 20.9435 * pi/180;
P.phi_1a = 0 * pi/180;
P.phi_2a = 10.9435 * pi/180;
P.phi_1f = 4.4611 * pi/180; %
P.phi_2f = 4.4770 * pi/180; %deve estar certo, mas conferir com odilon mesmo assim
P.z_f = 28.87e-3;

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
P.Mmax = 2;
P.Pmax = 4;
P.Mspace = linspace(P.phi1, P.phi2, P.Mmax+1);
P.its = 10;

%ploting

%log
P.log.all = false;