function r = Hz_out_proj(m, p, s, t) %eq 89
    P = params();

    r = P.b/(1j*P.omega*P.mu)*(2*pi)^2*summation();

    function acc = summation()
        fun = @(kz) G_Mz_TF0(P.b, 0, kz).*(k_rho0(kz).*M_z_Tef(0, kz, m, p).*M_z_Tef(0, kz, s, t) + k_rho0(-kz).*M_z_Tef(0, -kz, m, p).*M_z_Tef(0, -kz, s, t));
        acc = integral(fun, 0, P.its.Hz_out_proj.kz);
        for n = 1:P.its.Hz_out_proj.n
            fun = @(kz) G_Mz_TF0(P.b, n, kz).*(k_rho0(kz).*M_z_Tef(n, kz, m, p).*M_z_Tef(n, kz, s, t) + k_rho0(-kz).*M_z_Tef(n, -kz, m, p).*M_z_Tef(n, -kz, s, t) + k_rho0(kz).*M_z_Tef(-n, kz, m, p).*M_z_Tef(-n, kz, s, t) + k_rho0(-kz).*M_z_Tef(-n, -kz, m, p).*M_z_Tef(-n, -kz, s, t));
            acc = acc + integral(fun, 0, P.its.Hz_out_proj.kz);
        end
    end

    function r = k_rho0(kz)
        r = sqrt(P.k0^2 - kz.^2);
        r = cinv(r);
    end
end