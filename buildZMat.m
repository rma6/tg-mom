function r = buildZMat(P)
    r = cell(1);
    Zmatrix = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
    in = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
    out = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);

    for m = 1:P.Mmax
        for p = 1:P.Pmax
            for s = 1:P.Mmax
                for t = 1:P.Pmax
                    in((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = Hz_in_proj(m, p, s, t, P);
                    out((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = Hz_out_proj(m, p, s, t, P);
                    Zmatrix((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = in((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) - out((s-1)*P.Pmax+t, (m-1)*P.Pmax+p);
                end
            end
        end
    end

    r{1} = Zmatrix;
end