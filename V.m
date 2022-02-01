function r = V(t) %eq 94
    global a b omega mu phi_1f phi_2f delta_phi
    r = summation();

    function acc = summation()
        acc = 0;
        its = 100;
        for n = 1:its
            fun = @(rho) G_Mz_TFd(rho, n, t).*(n*pi./delta_phi*L./2).*I3(n, phi_1f, phi_2f).*J_vf_Tss(pho, n, t);
            acc = acc + integral(fun, a, b);
        end
    end
end