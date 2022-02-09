function r = G_Mz_TFd(rho, n, q, k) %eq 33: k é kd ou k0 a depender se a região é interna ou externa; rho and q might be arrays
    P = params();

    k_rho = sqrt(k.^2 - (q*pi/P.L).^2);
    if imag(k_rho) > 0
        k_rho = -k_rho;
    end

    r = theta_3_rho(n, q, k, rho)/(k_rho.*theta_1(n, q, k));
end