function r = z_in_m(dMatrix, Vmatrix) %eq 89
    P = params();
    
    r = -1/P.I0^2*summation();

    function acc = summation()
        acc = 0;
        for m = 1:P.Mmax
            for p = 1:P.Pmax
                acc = acc + dMatrix((m-1)*P.Pmax+p, 1)*Vmatrix((m-1)*P.Pmax+p, 1);
            end
        end
    end
end