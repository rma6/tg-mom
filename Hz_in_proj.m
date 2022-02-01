function r = Hz_in_proj(m, p, s, t) %eq 88
    if t == p
        global kd omega mu b delta_phi phi_1f phi_2f L
        k_pd = sqrt(kd.^2 - (p.*pi./L).^2); % q = p
        if imag(k_pd) > 0
            k_pd = -k_pd;
        end
    
        r = K_pd.^2.*b./(1j.*omega.*mu).*1./delta_phi.*L./2.*delta(t, p).*summation();
    else
        r = 0;
    end

    function acc = summation()
        acc = 0;
        its = 100;
        for n = 0:its
            acc = acc + En(n).*G_Mz_TFd(b, n, p, k_pd).*I3(n, phi_1m, phi_2m).*I3(n, phi_1f, phi_2f);
        end
    end

    function r = En(n)
        if  n == 0
            r = 1;
        else
            r = 2;
        end
    end
end