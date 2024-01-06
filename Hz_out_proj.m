function r = Hz_out_proj(m, p, s, t, P) %eq 94
    r = (2*pi)^2*P.b*summation();

    function acc = summation()
        acc = 0;
        for n = 0:P.its.nMax
            if n == 0
                fun = @(kz) Green_Mphi(P.b, 0, kz, P).*(M_phi_Tef(0, kz, m, p, P).*M_phi_Tef(0, -kz, s, t, P) ...
                                                      + M_phi_Tef(0, -kz, m, p, P).*M_phi_Tef(0, kz, s, t, P));
            else
                fun = @(kz) Green_Mphi(P.b, n, kz, P).*(M_phi_Tef(n, kz, m, p, P).*M_phi_Tef(-n, -kz, s, t, P) ...
                                                              + M_phi_Tef(n, -kz, m, p, P).*M_phi_Tef(-n, kz, s, t, P) ...
                                                              + M_phi_Tef(-n, kz, m, p, P).*M_phi_Tef(n, -kz, s, t, P) ...
                                                              + M_phi_Tef(-n, -kz, m, p, P).*M_phi_Tef(n, kz, s, t, P));
            end

            if P.fast
                acc = acc + quadgk(@(Akz) unmake_contour(Akz, fun(make_contour(Akz))), 0, P.its.Nkz*P.k0);
            else
                for k=1:P.its.Nkz
                    lower_lim = (k-1)*P.k0;
                    upper_lim = k*P.k0;
                    acc = acc + CGQ1(@(Akz) unmake_contour(Akz, fun(make_contour(Akz))), lower_lim, upper_lim, 16);
                end
            end
        end

        function Akz_out = make_contour(Akz)
            Akz_out = Akz;
            Akz_out(Akz <= P.k0 & n < 10) = Akz(Akz <= P.k0 & n < 10)*(1+1j*P.alpha);
            Akz_out(Akz > P.k0 & Akz < 2*P.k0 & n < 10) = Akz(Akz > P.k0 & Akz < 2*P.k0 & n < 10)*(1-1j*P.alpha) + 2j*P.k0*P.alpha;
        end

        function Ar_out = unmake_contour(Akz, Ar)
            Ar_out = Ar;
            Ar_out(Akz <= P.k0 & n < 10) = Ar((Akz <= P.k0 & n < 10))*(1+1j*P.alpha);
            Ar_out(Akz > P.k0 & Akz < 2*P.k0 & n < 10) = Ar((Akz > P.k0 & Akz < 2*P.k0 & n < 10))*(1-1j*P.alpha);
        end
    end
end
%ok