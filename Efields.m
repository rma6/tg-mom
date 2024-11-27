function [Etheta, Ephi] = Efields(theta, phi, dMat, P)
    krho0 = P.k0*sin(theta);
    ns = 1:P.nMax;

    Etheta = 2/sin(theta)*(1j*M_phi_Tef(0, P.k0*cos(theta))/besselh(0, 2, krho0*P.b)+sum(1j.^(ns+1)./besselh(ns, 2, krho0*P.b).*exp_M(theta, phi, 1)));
    Ephi = 2j*cos(theta)/(P.b*P.k0*sin(theta)^2)*sum(1j.^(ns+1).*ns./dH2(ns, krho0*P.b).*exp_M(theta, phi, -1));

    function r = exp_M(theta, phi, sign)
        r = zeros(1, P.nMax);
        for n = ns
            r(n) = exp(-1j*n*phi)*M_phi_Tef(n, P.k0*cos(theta)) + sign*exp(1j*n*phi)*M_phi_Tef(-n, P.k0*cos(theta));
        end
    end

    function r = M_phi_Tef(n, kz)
        r = 0;
        for m = 1:P.Mmax
            for p = 1:P.Pmax
                r = r + dMat((m-1)*P.Pmax+p, 1)*M_phi_mp_Tef(n, kz, m, p, P);
            end
        end
    end
end