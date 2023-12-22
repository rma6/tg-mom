function r = Green_Mphi(rho, n, kz, P) %eqs 94-96: kz might be array
    A_k_rho = sqrt(P.k0.^2 - kz.^2);
    A_k_rho = cinv(A_k_rho);

    if n == 0
        argmin = 2*10^(-P.expmin);
    else
        argmin = 2*10^((c_log(n)-P.expmin)/(1+n));
    end

    r = zeros(size(A_k_rho));
    for it = 1:size(A_k_rho, 2)
        k_rho = A_k_rho(it);

        if imag(k_rho*P.b) == 0 && abs(real(k_rho*P.b)) <= argmin
            if n == 0
                r(it) = 1j*P.omega*P.epsilon_0/k_rho*1/(1j*pi/2*k_rho*P.b + k_rho*P.b*log(P.gamma*real(k_rho*P.b)/2));
                %check calculations
            else
                r(it) = n/(1j*P.omega*P.mu*P.b);
                %check calculations
            end
        elseif real(k_rho*P.b) == 0 && abs(imag(k_rho*P.b)) <= argmin
            if n == 0
                r(it) = 1j*P.omega*P.epsilon_0/(k_rho*k_rho*P.b*log(P.gamma*imag(-k_rho*P.b)/2));                
                %check calculations
            else
                r(it) = n/(1j*P.omega*P.mu*P.b);
                %check calculations
            end
        elseif real(k_rho*P.b) == 0 && abs(imag(k_rho*P.b)) >= P.argmax
            r(it) = P.omega*P.epsilon_0/k_rho + (n*kz(it))^2/(P.omega*P.mu*k_rho*k_rho*P.b^2);
                %check calculations
        else
            dH2_besselh = dH2(n, k_rho*P.b)/besselh(n, 2, k_rho*rho);
            r(it) = 1j*P.omega*P.epsilon_0/k_rho*dH2_besselh ...
                +(n*kz(it))^2/(1j*P.omega*P.mu*P.b^2*k_rho^3*dH2_besselh);
        end
    end

    function r = c_log(ni)
        r = sum(log10(2:ceil(ni)))-log10(2*pi);
    end
end