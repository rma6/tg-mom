function r = G_Mz_TF0(rho, n, kz) %eq 56: kz might be array
    P = params();

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
                r(it) = k_rho^2*P.b*(1j*pi/2 + log(P.gamma*real(k_rho*P.b)/2));
            else
                r(it) = -k_rho^2*P.b/n;
            end
        elseif real(k_rho*P.b) == 0 && abs(imag(k_rho*P.b)) <= argmin
            if n == 0
                r(it) = k_rho^2*P.b*log(P.gamma*imag(-k_rho*P.b)/2);
            else
                r(it) = -k_rho^2*P.b/n;
            end
        elseif real(k_rho*P.b) == 0 && abs(imag(k_rho*P.b)) >= P.argmax
            r(it) = 1j*k_rho;
        else
            r(it) = k_rho*besselh(n, 2, k_rho*rho)/dH2(n, k_rho*P.b);
        end
    end

    function r = c_log(ni)
        r = sum(log10(2:ceil(ni)))-log10(2*pi);
    end
end