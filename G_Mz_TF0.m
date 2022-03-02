function r = G_Mz_TF0(rho, n, kz) %eq 56: rho and kz might be arrays
    P = params();

    k_rho = sqrt(P.k0.^2 - kz.^2);
    k_rho = cinv(k_rho);

    r = besselh(n, 2, k_rho*rho)/dH2(n, k_rho.*P.b);
end