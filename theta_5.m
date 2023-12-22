function r = theta_5(n, q, k, P) %thetas appendix: adição de K aos parâmetros para diferenciar região interna de externa (kd | k0); q might be array
    ni = n*pi/P.delta_phi;

    A_k_rho = sqrt(k.^2 - (q*pi/P.L).^2);
    A_k_rho = cinv(A_k_rho);

    if ni == 0
        argmin = 2*10^(-P.expmin);
    else
        argmin = 2*10^((c_log(ni)-P.expmin)/(1+ni));
    end

    r = zeros(size(A_k_rho));
    for it = 1:size(A_k_rho, 2)
        k_rho = A_k_rho(it);

        if abs(k_rho*P.a) > P.argmax
            r(it) = 2j/(pi*k_rho*sqrt(P.a*P.b))*sin(k_rho*(P.b-P.a));
        elseif abs(k_rho*P.a) < argmin &&  ni == 0
            r(it) = 2j/pi*log(P.b/P.a);
        elseif abs(k_rho*P.a) < argmin &&  ni ~= 0
            r(it) = 1j/(ni*pi)*((P.b/P.a)^ni - (P.a/P.b)^ni);
        else
            r(it) = besselj(ni, k_rho*P.b)*besselh(ni, 2, k_rho*P.a) - besselj(ni, k_rho*P.a)*besselh(ni, 2, k_rho*P.b);
        end
    end

    function r = c_log(ni)
        r = sum(log10(2:ceil(ni)))-log10(2*pi);
    end
end
%ok