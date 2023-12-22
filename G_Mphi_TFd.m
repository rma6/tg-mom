function r = G_Mphi_TFd(rho, n, q, P) %eq 105: rho and q might be arrays
    k_rho = sqrt(P.kd.^2 - (q*pi/P.L).^2);
    k_rho = cinv(k_rho);

    r = -n*pi*q*pi./(P.b*P.delta_phi*P.L*k_rho.^3).*theta_3_rho(n, q, P.kd, rho, P)./(theta_1(n, q, P.kd, P));
end
%ok