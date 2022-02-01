function r = J_vf_Tss(rho, n, q) %eq 77 ok
    global I0 L delta_phi_f delta_phi phi_1f phi1 phi_2f z_f z1
    r = 4*I0./(n*pi*L*rho*delta_phi_f)*(cos(n*pi/delta_phi*(phi_1f-phi1))-cos(n*pi/delta_phi*(phi_2f-phi1)))*sin(q*pi/L*(z_f-z1));
end