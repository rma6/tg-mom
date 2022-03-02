function r = I3(n, m) %eq 62 ok
    P = params();
    
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
        r = phi_2m-phi_1m;
    else
        r = P.delta_phi/(n*pi)*(sin(n*pi/P.delta_phi*(phi_2m-P.phi1))-sin(n*pi/P.delta_phi*(phi_1m-P.phi1)));
    end
end