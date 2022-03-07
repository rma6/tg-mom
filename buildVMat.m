function Vmatrix = buildVMat(P)
    Vmatrix = zeros(P.Mmax*P.Pmax, 1);

    for m = 1:P.Mmax
        for p = 1:P.Pmax
            for s = 1:P.Mmax
                for t = 1:P.Pmax
                    Vmatrix((s-1)*P.Pmax+t, 1) = V(s, t, P);
                end
            end
        end
    end
end