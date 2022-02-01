function r = theta_1(n, q, k_pd) %eq 30: adição de K_pd aos parâmetros para diferencias região interna de externa
    global delta_phi a b
    ni = n.*pi./delta_phi;
    r = dJ(k_pd.*b).*dH(k_pd.*a) - dJ(k_pd.*a).*dH(k_pd.*b);
    
    function r = dJ(x)
        r = (ni.*besselj(ni, x))./x - besselj(ni + 1, x);
    end

    function r = dH(x)
        r = (ni.*besselh(ni, 2, x))./x - besselh(ni + 1, 2, x);
    end
end