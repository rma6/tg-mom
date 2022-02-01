function r = G_Mz_TFd(rho, n, q, k_pd) %eq 33: k é kd ou k0 a depender se a região é interna ou externa
    global delta_phi a
    ni = n.*pi./delta_phi;

    r = 1./(k_pd.*theta_1(n, q, k_pd)).*(besselj(ni, k_pd.*rho).*dH(k_pd.*a) - dJ(k_pd.*a).*besselh(ni, 2, k_pd.*rho));
    
    function r = dJ(x)
            r = (ni.*besselj(ni, x))./x - besselj(ni + 1, x);
    end

    function r = dH(x)
        r = (ni.*besselh(ni, 2, x))./x - besselh(ni + 1, 2, x);
    end
end