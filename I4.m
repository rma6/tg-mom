function r = I4(n, m) %eq 67 ok
    global Mspace delta_phi phi2 phi1
    phi_1m = Mspace(m);
    phi_2m = Mspace(m+1);
    if n == 0
        r = phi_2m-phi_1m;
    else
        r = exp(1j*n*phi_2m)-exp(1j*n*phi_1m)/(1j*n);
    end
end