P = params();

if P.log.all
    fid = fopen("logs/log.txt", "w");
    fclose(fid);
end

Zmatrix = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
in = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
out = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
Vmatrix = zeros(P.Mmax*P.Pmax, 1);

for m = 1:P.Mmax
    for p = 1:P.Pmax
        for s = 1:P.Mmax
            for t = 1:P.Pmax
                Vmatrix((s-1)*P.Pmax+t, 1) = V(s, t);
                in((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = Hz_in_proj(m, p, s, t);
                out((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = Hz_out_proj(m, p, s, t);
                Zmatrix((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = in((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) - out((s-1)*P.Pmax+t, (m-1)*P.Pmax+p);
            end
        end
    end
end

dMatrix = Zmatrix\Vmatrix;

z_in_f()+z_in_m(dMatrix, Vmatrix)