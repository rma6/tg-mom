function r = Hphi_out_proj(m, p, s, t, P) %eq 97
    r = (2*pi)^2*P.b*summation();

    function acc = summation()
        acc = 0;
        for n = 0:P.nMax
            if n == 0
                fun = @(kz) Green_Mphi(P.b, 0, kz, P).*(M_phi_mp_Tef(0, kz, m, p, P).*M_phi_mp_Tef(0, -kz, s, t, P) ...
                                                      + M_phi_mp_Tef(0, -kz, m, p, P).*M_phi_mp_Tef(0, kz, s, t, P));
            else
                fun = @(kz) Green_Mphi(P.b, n, kz, P).*(M_phi_mp_Tef(n, kz, m, p, P).*M_phi_mp_Tef(-n, -kz, s, t, P) ...
                                                              + M_phi_mp_Tef(n, -kz, m, p, P).*M_phi_mp_Tef(-n, kz, s, t, P) ...
                                                              + M_phi_mp_Tef(-n, kz, m, p, P).*M_phi_mp_Tef(n, -kz, s, t, P) ...
                                                              + M_phi_mp_Tef(-n, -kz, m, p, P).*M_phi_mp_Tef(n, kz, s, t, P));
            end

            acc = acc + quadgk(@(Akz) fun(Akz), 0, P.Nkz*P.k0);
        end
    end
end