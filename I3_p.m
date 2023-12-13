function r = I3_p(q, p, P) %eq 62
    if p <= (P.Pmax/2)
	  Lp = (P.z_1a - P.z1)/(P.Pmax/2);
	  z_1p = P.z1 + (p-1)*Lp;
	  z_2p = P.z1 + p*Lp;
	else
	  Lp = (P.z2 - P.z_2a)/(P.Pmax/2);
	  z_1p = P.z_2a + (p-P.Pmax/2-1)*Lp;
	  z_2p = P.z_2a + (p-P.Pmax/2)*Lp;
    end
    
    if q == 0
        r = z_2p-z_1p;
    else
        r = P.L/(q*pi)*(sin(q*pi/P.L*(z_2p-P.z1))-sin(q*pi/P.L*(z_1p-P.z1)));
    end
end
%todo: check if z_1p and z_2p calculation is correct and if parameter M and
%P are the same as the old formulation