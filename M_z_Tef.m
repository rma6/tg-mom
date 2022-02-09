function r = M_z_Tef(n, kz, m, p) %eq 72; kz might be array; ok
    P = params();
    
    r = exp(1j*kz*P.z1)*(p*pi/P.L)/((2*pi)^2*((p*pi/P.L)^2-kz.^2))*(1-exp(1j*kz*P.L*(-1)^p))*I4(n, m);

    if P.log.all
        fid = fopen("logs/log.txt", "a");
        for it = 1:size(kz, 2)
            fprintf(fid, "M_z_Tef(%i, %e, %i, %i) = %e\n", n, kz(it), m, p, r(it));
        end
        fclose(fid);
    end
end