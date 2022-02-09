function r = theta_3_rho(n, q, k, rho) %eq 30': adição de K aos parâmetros para diferenciar região interna de externa (kd | k0); q and rho might be arrays
    P = params();

    ni = n*pi/P.delta_phi;

    A_k_rho = sqrt(k.^2 - (q*pi/P.L).^2);
    if imag(A_k_rho) > 0
        A_k_rho = -A_k_rho;
    end

    if ni ==0
        argmin = 2*10^(-P.expmin);
    else
        argmin = 2*10^((log10(gamma(ni)/(2*pi))-P.expmin)/(1+ni));
    end

    if size(rho, 2) > 1
        k_rho = A_k_rho;

        if abs(k_rho) > P.argmax
            r = -2j./(pi*k_rho*sqrt(P.a*rho)).*(sin(k_rho*(rho-P.a))/(2*k_rho*P.a)+cos(k_rho*(rho-P.a)));
        elseif abs(k_rho) < argmin &&  ni == 0
            r = -2j/pi*(1/(k_rho*P.a)+k_rho*P.a/2*exp(P.gamma*k_rho*rho/2));
        elseif abs(k_rho) < argmin &&  ni ~= 0
            r = -1j/(pi*k_rho)*((rho/P.a).^ni/P.a + (P.a./rho).^(ni-1)./rho);
        else
            r = besselj(ni, k_rho*rho)*dH2(ni, k_rho*P.a) - dJ(ni, k_rho*P.a)*besselh(ni, 2, k_rho*rho);
        end
    else
        r = zeros(size(A_k_rho));
        for it = 1:size(A_k_rho, 2)
            k_rho = A_k_rho(it);
    
            if abs(k_rho) > P.argmax
                r(it) = -2j/(pi*k_rho*sqrt(P.a*rho))*(sin(k_rho*(rho-P.a))/(2*k_rho*P.a)+cos(k_rho*(rho-P.a)));
            elseif abs(k_rho) < argmin &&  ni == 0
                r(it) = -2j/pi*(1/(k_rho*P.a)+k_rho*P.a/2*exp(P.gamma*k_rho*rho/2));
            elseif abs(k_rho) < argmin &&  ni ~= 0
                r(it) = -1j/(pi*k_rho)*((rho/P.a)^ni/P.a + (P.a/rho)^(ni-1)/rho);
            else
                r(it) = besselj(ni, k_rho*rho)*dH2(ni, k_rho*P.a) - dJ(ni, k_rho*P.a)*besselh(ni, 2, k_rho*rho);
            end
        end 
    end
end