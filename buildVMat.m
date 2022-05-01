function r = buildVMat(P, q) %builds V matrix
    r = cell(1);
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

    send(q, sprintf("finished buildVMat@%f at %s", P.omega/(2*pi), string(datetime)));

    r{1} = Vmatrix;
end