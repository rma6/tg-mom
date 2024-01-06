function r = z_in_m(d_mat, V_mat, P) %eq 99
    r = -1/P.I0^2*(V_mat' * d_mat);
end