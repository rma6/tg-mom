function r = z_in_m(dMatrix, Vmatrix, P) %eq 89
    r = -1/P.I0^2*(Vmatrix' * dMatrix);
end