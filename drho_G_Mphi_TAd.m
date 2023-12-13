function r = drho_G_Mphi_TAd(rho, n, q, P) %eq 103: rho and q might be arrays
    k_rho = sqrt(P.kd.^2 - (q*pi/P.L).^2);
    k_rho = cinv(k_rho);

    r = -1j*P.omega*P.epsilon_d./k_rho.*theta_7_rho(n, q, P.kd, rho, P)./(theta_5(n, q, P.kd, P));
end