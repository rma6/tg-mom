function r = I4_m(n, m, P) %eq 67 ok
    if m <= (P.Mmax/2)
	  deltaphi = (P.phi_1a - P.phi1)/(P.Mmax/2);
	  phi_1m = P.phi1 + (m-1)*deltaphi;
	  phi_2m = P.phi1 + m*deltaphi;
	else
	  deltaphi = (P.phi2 - P.phi_2a)/(P.Mmax/2);
	  phi_1m = P.phi_2a + (m-P.Mmax/2-1)*deltaphi;
	  phi_2m = P.phi_2a + (m-P.Mmax/2)*deltaphi;
    end

    if n == 0
        r = deltaphi;
    else
        r = (exp(1j*n*phi_2m)-exp(1j*n*phi_1m))/(1j*n);
    end
end
%ok