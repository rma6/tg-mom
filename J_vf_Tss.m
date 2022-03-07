function r = J_vf_Tss(rho, n, q, P) %eq 77 ok    
    r = 4*P.I0./(n*pi*P.L*rho*P.delta_phi_f)*(cos(n*pi/P.delta_phi*(P.phi_1f-P.phi1))-cos(n*pi/P.delta_phi*(P.phi_2f-P.phi1)))*sin(q*pi/P.L*(P.z_f-P.z1));
end
%ok