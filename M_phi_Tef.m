function r = M_phi_Tef(n, kz, m, p, P) %eq 75; kz might be array
    r = 1/(2*pi)^2*exp(1j*n*P.phi1)/((m*pi/P.delta_phi)^2-n^2)*m*pi/P.delta_phi*(1-(-1)^m*exp(1j*n*P.delta_phi)).*I4_p(kz, p, P);
end