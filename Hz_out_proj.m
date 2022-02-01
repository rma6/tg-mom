function r = Hz_out_proj(p, phi_1m, phi_2m) %eq 89
    global k0 b omega mu phi_1f phi_2f L
    k_p0 = sqrt(k0.^2 - (p.*pi./L).^2); %posso trocar p por q?
    if imag(k_p0) > 0
        k_p0 = -k_p0;
    end

    r = k_p0.^2.*b./(1j.*omega.*mu).*summation();

    function acc = summation()
        acc = 0;
        its = 100;
        for n = -its:its %ver com odilon como que é o esquema de somar de 0 a N, para economizar integrais
            fun = @(kz) G_Mz_TFd(b, n, kz, k_p0).*M_z_Tef(n, kz, phi_1m, phi_2m, p).*(2.*pi).^2.*M_z_Tef(n, kz, phi_1f, phi_2f, p);
            acc = acc + integral(fun, -its, its);
        end
    end
end