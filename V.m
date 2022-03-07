function r = V(s, t, P) %eq 94
    r = pi*P.L/(P.delta_phi*2)*summation();

    function acc = summation()
        acc = 0;
        for n = 1:P.its.V.n
            fun = @(rho) G_Mz_TFd(rho, n, t, P)*n*I3(n, s, P).*J_vf_Tss(rho, n, t, P);
            acc = acc + integral(fun, P.a, P.b);
        end
    end
end