function r = Hz_out_proj(m, p, s, t) %eq 89
    P = params();

    r = P.b/(1j*P.omega*P.mu)*(2*pi)^2*summation();

    function acc = summation()
        acc = 0;
        for n = 0:P.its.Hz_out_proj.n
            if n == 0
                fun = @(kz) G_Mz_TF0(P.b, 0, kz).*(M_z_Tef(0, kz, m, p).*M_z_Tef(0, -kz, s, t) + M_z_Tef(0, -kz, m, p).*M_z_Tef(0, kz, s, t));
            else
                fun = @(kz) G_Mz_TF0(P.b, n, kz).*(M_z_Tef(n, kz, m, p).*M_z_Tef(-n, -kz, s, t) + M_z_Tef(n, -kz, m, p).*M_z_Tef(-n, kz, s, t) + M_z_Tef(-n, kz, m, p).*M_z_Tef(n, -kz, s, t) + M_z_Tef(-n, -kz, m, p).*M_z_Tef(n, kz, s, t));
            end

%             cZzz2 = 0;
%             for k=1:P.its.Nkz
%                 rkzl = (k-1)*P.k0;
%                 rkzu = k*P.k0;
%                 cZzz2 = cZzz2 + CGQ1(fun, rkzl, rkzu, 16);
%             end

            cZzz2 = CGQ1(fun, 0, P.its.Hz_out_proj.kz, 16);
            acc = acc + cZzz2;
        end
    end
end