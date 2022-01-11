clear

%constants
global mu epsilon_d
mu = 1;
epsilon_d = 1;

%geometric parameters
global z1 z2 a b phi1 phi2 phi_1a phi_2a phi_1f phi_2f z_f
z1 = 0;
z2 = 0.1;
a = 0.9;
b = 1;
phi1 = 0;
phi2 = 20 * pi / 180;
phi_1a = 8 * pi / 180;
phi_2a = 12 * pi / 180;
phi_1f = 9.5 * pi / 180;
phi_2f = 10.5 * pi / 180;
z_f = 0.05;

%source parameters
global omega I0
omega = 500e6;
I0 = 0.1;

%aliases
global L delta_phi delta_phia delta_phi_f kd
L = z2 - z1;
delta_phi = phi2 - phi1;
delta_phia = phi_2a - phi_1a;
delta_phi_f = phi_2f - phi_1f;
kd = omega*sqrt(mu*epsilon_d);

%interface segmentation
global z_segs phi_segs delta_z_m delta_phi_m
z_segs = 10; %z_segs segments along z
phi_segs = 10; %phi_segs segments along phi
delta_z_m = L/z_segs;
delta_phi_m = delta_phi/phi_segs;

%iteration variables
global z_1m z_2m

for z_m = z2-delta_z_m/2:-delta_z_m:z1
    phi_1m = z_m-delta_z_m/2;
    phi_2m = z_m+delta_z_m/2;
    for phi_m = phi1+delta_phi_m/2:delta_phi_m:phi2
        z_1m = z_m-delta_phi_m/2;
        z_2m = z_m+delta_phi_m/2;
    end
end

function r = I3(n, phi_1m, phi_2m) %eq 62
    global delta_phi phi2 phi1
    if n == 0
        r = phi2-phi1;
    else
        r = delta_phi/(n*pi)*(sin(n*pi/delta_phi*(phi_2m-phi1))-sin(n*pi/delta_phi*(phi_1m-phi1)));
    end
end

function r = J_vf_Tss(rho, n, q) %eq 77
    global I0 L delta_phi_f delta_phi phi_1f phi1 phi_2f z_f z1
    r = 4*I0/(n*pi*L*rho*delta_phi_f)*(cos(n*pi/delta_phi*(phi_1f-phi1))-cos(n*pi/delta_phi*(phi_2f-phi1)))*sin(q*pi/L*(z_f-z1));
end

function r = theta_1(n, q) %eq 30
    %todo: ver como fica as derivadas e comportamentos assintóticos com odilon
end

function r = G_Mz_TFd(rho, n, q) %eq 33
    global kd L
    k_pd = kd^2 - (q*pi/L)^2;
    r = 1/(k_pd*theta_1(n, q))*(); %todo: ver como fica as derivadas e comportamentos assintóticos com odilon
end

function