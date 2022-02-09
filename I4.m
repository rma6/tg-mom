function r = I4(n, m) %eq 67 ok
    P = params();

    phi_1m = P.Mspace(m);
    phi_2m = P.Mspace(m+1);

    if n == 0
        r = phi_2m-phi_1m;
    else
        r = exp(1j*n*phi_2m)-exp(1j*n*phi_1m)/(1j*n);
    end
end