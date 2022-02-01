function r = z_in_f() %eq 108
    global L I0 omega mu delta_phi b a kd
    rho0 = (a+L)./2;
    
    r = -1./I0.^2.*1j.*omega.*mu.*delta_phi.*L./4.*(b-a).*rho0.*summation(rho0, delta_phi, L, kd);

    function acc = summation(rho0, delta_phi, L, kd)
        acc = 0;
        its = 100;
        for n = 1:its
            for q = 1:its
                knq = sqrt((n.*pi./(rho0.*delta_phi)).^2+(q.*pi./L).^2);
                acc = acc + J_vf_Tss(rho0, n, q).^2./(kd.^2-knq.^2);
            end
        end
    end
end