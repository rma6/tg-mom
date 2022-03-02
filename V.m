function r = V(s, t) %eq 94
    P = params();
    
    r = pi*P.L/(P.delta_phi*2)*summation();

    function acc = summation()
        acc = 0;
        for n = 1:P.its.V.n
            fun = @(rho) G_Mz_TFd(rho, n, t)*n*I3(n, s).*J_vf_Tss(rho, n, t);
            acc = acc + integral(fun, P.a, P.b);
        end
    end
end