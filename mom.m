clear

%constants
global mu epsilon_0 epsilon_d
mu = 4*pi*10.^-7;
epsilon_0 = 8.85e-12;
epsilon_d = 2.55*epsilon_0.*(1-1j*tan(2.2e-3));

%geometric parameters
global z1 z2 a b phi1 phi2 phi_1a phi_2a phi_1f phi_2f z_f
z1 = 0;
z2 = 59.45e-3;
a = 250e-3;
b = 253.048e-3;
phi1 = 10 * pi/180;
phi2 = 20.9435 * pi/180;
phi_1a = 0 * pi/180;
phi_2a = 10.9435 * pi/180;
phi_1f = 4.4611 * pi/180; %
phi_2f = 4.4770 * pi/180; %deve estar certo, mas conferir com odilon mesmo assim
z_f = 28.87e-3;

%source parameters
global omega I0
omega = 2.45e9*2*pi;
I0 = 1;

%aliases
global L delta_phi delta_phia delta_phi_f kd k0
L = z2 - z1;
delta_phi = phi2 - phi1;
delta_phia = phi_2a - phi_1a;
delta_phi_f = phi_2f - phi_1f;
kd = omega*sqrt(mu*epsilon_d);
k0 = omega*sqrt(mu*epsilon_0);

%iteration variables
global Mspace
Mmax = 2;
Pmax = 4;
Mspace = linspace(phi1, phi2, Mmax+1);

for m = 1:Mmax
%     phi_1m = Mspace(m);
%     phi_2m = Mspace(m+1);
    for p = 1:Pmax
        for s = 1:Mmax
%             phi_1s = Mspace(s);
%             phi_2s = Mspace(s+1);
            for t = 1:Pmax
            end
        end
    end
end

integral(@(rho) J_vf_Tss(rho, 5, 3),a,b)

%Hz_out_proj(1, phi_1m, phi_2m)
%z_in_f()