function r = buildVMat(P, queue) %builds V matrix
    send(queue, sprintf("started buildVMat@%f at %s", P.omega/(2*pi), string(datetime)));

    r = cell(1);
    Vmatrix = zeros(P.Mmax*P.Pmax, 1);

    for s = 1:P.Mmax
        for t = 1:P.Pmax
            Vmatrix((s-1)*P.Pmax+t, 1) = V(s, t, P);
        end
    end

    send(queue, sprintf("finished buildVMat@%f at %s", P.omega/(2*pi), string(datetime)));

    r{1} = Vmatrix;
end
%ok