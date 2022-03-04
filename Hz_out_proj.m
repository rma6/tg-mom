function r = Hz_out_proj(m, p, s, t) %eq 89
    P = params();

    r = P.b/(1j*P.omega*P.mu)*(2*pi)^2*summation();

    function acc = summation()
        fun = @(kz) G_Mz_TF0(P.b, 0, kz).*(M_z_Tef(0, kz, m, p).*M_z_Tef(0, -kz, s, t) + M_z_Tef(0, -kz, m, p).*M_z_Tef(0, kz, s, t));
        acc = integral(fun, 0, P.its.Hz_out_proj.kz);
        fprintf("n=0 int=%d + %di\n",real(acc), imag(acc))
        for n = 1:P.its.Hz_out_proj.n
            fun = @(kz) G_Mz_TF0(P.b, n, kz).*(M_z_Tef(n, kz, m, p).*M_z_Tef(-n, -kz, s, t) + M_z_Tef(n, -kz, m, p).*M_z_Tef(-n, kz, s, t) + M_z_Tef(-n, kz, m, p).*M_z_Tef(n, -kz, s, t) + M_z_Tef(-n, -kz, m, p).*M_z_Tef(n, kz, s, t));
            temp = integral(fun, 0, P.its.Hz_out_proj.kz);
            fprintf("n=%i int=%d + %di\n",n,real(temp), imag(temp))
            acc = acc + temp;
        end
    end
end