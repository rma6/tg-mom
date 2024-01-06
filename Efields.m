function [Etheta, Ephi] = Efields(theta, phi, dMat, P)
    krho0 = P.k0*sin(theta);

    common = radpat_common(theta, phi);
    ns = 1:P.its.nMax;

    Etheta = 2/sin(theta)*(1j*M_phi_Tef_mp(0, P.k0*cos(theta))/besselh(0, 2, krho0*P.b)+sum(1j.^(ns+1)./besselh(ns, 2, krho0*P.b).*common));
    Ephi = 2j*cos(theta)/(P.b*P.k0*sin(theta)^2)*sum(1j.^(ns+1).*ns./dH2(ns, krho0*P.b).*common);

    function r = radpat_common(theta, phi)
        r = [];
        for n = 1:P.its.nMax
            r(end+1) = exp(-1j*n*phi)*M_phi_Tef_mp(n, P.k0*cos(theta)) + exp(1j*n*phi)*M_phi_Tef_mp(-n, P.k0*cos(theta));
        end
    end

    function r = M_phi_Tef_mp(n, kz)
        r = 0;
        for m = 1:P.Mmax
            for p = 1:P.Pmax
                r = r + dMat((m-1)*P.Pmax+p, 1)*M_phi_Tef(n, kz, m, p, P);
            end
        end
    end
end