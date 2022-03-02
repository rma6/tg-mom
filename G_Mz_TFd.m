function r = G_Mz_TFd(rho, n, q) %eq 33: k é kd ou k0 a depender se a região é interna ou externa; rho and q might be arrays
    P = params();

    k_rho = sqrt(P.kd.^2 - (q*pi/P.L).^2);
    k_rho = cinv(k_rho);

    r = theta_3_rho(n, q, P.kd, rho)/(k_rho.*theta_1(n, q, P.kd));
end