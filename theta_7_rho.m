function r = theta_7_rho(n, q, k, rho, P) %thetas appendix: adição de K aos parâmetros para diferenciar região interna de externa (kd | k0); q and rho might be arrays
    ni = n*pi/P.delta_phi;

    A_k_rho = sqrt(k.^2 - (q*pi/P.L).^2);
    A_k_rho = cinv(A_k_rho);

    if ni == 0
        argmin = 2*10^(-P.expmin);
    else
        argmin = 2*10^((c_log(ni)-P.expmin)/(1+ni));
    end

    if size(rho, 2) > 1
        k_rho = A_k_rho;

        if abs(k_rho*P.a) > P.argmax
            r = 2j./(pi*k_rho*sqrt(P.a*rho)).*(cos(k_rho*(rho-P.a))-sin(k_rho*(rho-P.a))./(2*k_rho*rho)); %todo: test 2*k_rho*rho; is k_rho array?
        elseif abs(k_rho*P.a) < argmin &&  ni == 0
            r = 2j/pi*(1./(k_rho*rho)+k_rho*rho/2*log(P.gamma*k_rho*P.a/2));
        elseif abs(k_rho*P.a) < argmin &&  ni ~= 0
            r = 1j/(pi*k_rho)*((rho/P.a).^(ni-1)/P.a + (P.a./rho).^ni./rho);
        else
            r = dJ(ni, k_rho*rho)*besselh(ni, 2, k_rho*P.a) - besselj(ni, k_rho*P.a)*dH2(ni, k_rho*rho);
        end
    else
        r = zeros(size(A_k_rho));
        for it = 1:size(A_k_rho, 2)
            k_rho = A_k_rho(it);
    
            if abs(k_rho*P.a) > P.argmax
                r(it) = 2j/(pi*k_rho*sqrt(P.a*rho))*(cos(k_rho*(rho-P.a))-sin(k_rho*(rho-P.a))/(2*k_rho*rho));
            elseif abs(k_rho*P.a) < argmin &&  ni == 0
                r(it) = 2j/pi*(1/(k_rho*rho)+k_rho*rho/2*log(P.gamma*k_rho*P.a/2));
            elseif abs(k_rho*P.a) < argmin &&  ni ~= 0
                r(it) = 1j/(pi*k_rho)*((rho/P.a)^(ni-1)/P.a + (P.a/rho)^ni/rho);
            else
                r(it) = dJ(ni, k_rho*rho)*besselh(ni, 2, k_rho*P.a) - besselj(ni, k_rho*P.a)*dH2(ni, k_rho*rho);
            end
        end 
    end

    function r = c_log(ni)
        r = sum(log10(2:ceil(ni)))-log10(2*pi);
    end
end
%ok