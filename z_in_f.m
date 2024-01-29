function r = z_in_f(P) %eq 108
    rho0 = (P.a+P.b)/2;
    
    r = -1/P.I0^2*1j*P.omega*P.mu*P.delta_phi*P.L/4*(P.b-P.a)*rho0*summation();

    function acc = summation()
        acc = 0;
        for n = 1:P.its.nMax
            for q = 1:P.its.qMax
                k_nq = sqrt((n*pi/(rho0*P.delta_phi))^2+(q*pi/P.L)^2);
                acc = acc + J_vf_Tss(rho0, n, q, P)^2/(P.kd^2-k_nq^2);
            end
        end
    end
end
%ok