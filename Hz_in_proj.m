function r = Hz_in_proj(m, p, s, t) %eq 88 ok'G_Mz_TFd
    if t == p
        P = params();
        
        k_rhod = sqrt(P.kd^2 - (p*pi/P.L)^2); % q == p
        if imag(k_rhod) > 0
            k_rhod = -k_rhod;
        end
    
        r = k_rhod^2*P.b/(1j*P.omega*P.mu)*1/P.delta_phi*P.L/2*summation();
    else
        r = 0;
    end

    function acc = summation()
        acc = 0;
        for n = 0:P.its.Hz_in_proj
            acc = acc + En(n)*G_Mz_TFd(P.b, n, p, P.kd)*I3(n, m)*I3(n, s);
        end
    end

    function r = En(n)
        if  n == 0
            r = 1;
        else
            r = 2;
        end
    end
end