function r = z_in_m(dMatrix, Vmatrix, P) %eq 99
    r = -1/P.I0^2*(Vmatrix' * dMatrix);
end