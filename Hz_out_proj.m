function r = Hz_out_proj(m, p, s, t) %eq 89 ok'G_Mz_TFd
    P = params();

    r = P.b/(1j*P.omega*P.mu)*(2*pi)^2*summation();

    function acc = summation()
        acc = 0;
        for n = -P.its.Hz_out_proj.n:P.its.Hz_out_proj.n %ver com odilon como que é o esquema de somar de 0 a N, para economizar integrais
            

            fun = @(kz) k_rho0(kz).^2.*G_Mz_TFd(P.b, n, kz, k_rho0(kz)).*M_z_Tef(n, kz, m, p).*M_z_Tef(n, kz, s, t);
            acc = acc + integral(fun, -P.its.Hz_out_proj.kz, P.its.Hz_out_proj.kz);
        end
    end

    function r = k_rho0(kz)
        r = sqrt(P.k0^2 - kz.^2);
        if imag(r) > 0
            r = -r;
        end
    end
end