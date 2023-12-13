function r = Hz_in_proj(m, p, s, t, P) %eq 88
    if t == p        
        k_rhod2 = P.kd^2 - (p*pi/P.L)^2; % q == p
    
        r = k_rhod2*P.b/(1j*P.omega*P.mu)*1/P.delta_phi*P.L/2*summation();
    else
        r = 0;
    end

    function acc = summation()
        acc = 0;
        for n = 0:P.its.Hz_in_proj
            acc = acc + E(n)*G_Mz_TFd(P.b, n, p, P)*I3_m(n, m, P)*I3_m(n, s, P);
        end
    end
end