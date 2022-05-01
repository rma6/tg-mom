function r = M_z_Tef(n, kz, m, p, P) %eq 72; kz might be array
    r = exp(1j*kz*P.z1)*(p*pi/P.L)./((2*pi)^2*((p*pi/P.L)^2-kz.^2)).*(1-exp(1j*kz*P.L)*(-1)^p)*I4(n, m, P);
end