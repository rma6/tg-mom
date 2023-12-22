function r = Hz_in_proj(m, p, s, t, P) %eq 89
    %note that m==n==s or the results is 0
    if m == s    
        r = P.b*P.delta_phi/(2*P.L)*summation();
    else
        r = 0;
    end

    function acc = summation()
        acc = 0;
        temp = m*pi^2/(1j*P.omega*P.mu*P.b*P.delta_phi*P.L);
        for q = 0:P.its.Hz_in_proj
            acc = acc + E(q)*(-drho_G_Mphi_TAd(P.b, m, q, P)-temp*q*G_Mphi_TFd(P.b, m, q, P))*I3_p(q, p, P)*I3_p(q, t, P);
        end
    end
end
%ok