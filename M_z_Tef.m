function r = M_z_Tef(n, kz, phi_1m, phi_2m, p) %eq 72
    global z1 L
    r = exp(1j.*kz.*z1).*(p.*pi./L)./((2.*pi).^2.*((p.*pi./L).^2-kz.^2)).*(1-exp(1j.*kz.*L.*(-1).^p)).*I4(n, phi_1m, phi_2m);
end