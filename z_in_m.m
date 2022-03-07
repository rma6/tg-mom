function r = z_in_m(dMatrix, Vmatrix) %eq 89
    P = params();
    
    r = -1/P.I0^2*(Vmatrix' * dMatrix);
end