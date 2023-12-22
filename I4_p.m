function r = I4_p(kz, p, P) %eq 73: kz might be array
    if p <= (P.Pmax/2)
	  deltaz = (P.z_1a - P.z1)/(P.Pmax/2);
	  z_1p = P.z1 + (p-1)*deltaz;
	  z_2p = P.z1 + p*deltaz;
	else
	  deltaz = (P.z2 - P.z_2a)/(P.Pmax/2);
	  z_1p = P.z_2a + (p-P.Pmax/2-1)*deltaz;
	  z_2p = P.z_2a + (p-P.Pmax/2)*deltaz;
    end

%     if kz == 0
%         r = deltaz;
%     else
%         r = (exp(1j*kz*z_2p)-exp(1j*kz*z_1p))/(1j*kz);
%     end
    r = (exp(1j*kz*z_2p)-exp(1j.*kz.*z_1p))./(1j*kz);
end