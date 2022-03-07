clear;
pool = gcp();

Vmatrix = buildVMat(params());

freqs = 2.2:0.05:2.7;

for it = 1:size(freqs, 2)
    jobs(it) = parfeval(pool, @buildZMat, 1, params(freqs(it)));
end

M = cell(2, size(freqs, 2));
for it = 1:size(freqs, 2)
    [~, value] = fetchNext(jobs);
    M(:,it) = value;
end

for it = 1:size(freqs, 2)
    zinm(it) = z_in_m(M{2, it}, Vmatrix, params(freqs(it)));
    zinf(it) = z_in_f(params(freqs(it)));
end

% P = params();
% Zmatrix = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
% in = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
% out = zeros(P.Mmax*P.Pmax, P.Mmax*P.Pmax);
% Vmatrix = zeros(P.Mmax*P.Pmax, 1);
% for m = 1:P.Mmax
%     for p = 1:P.Pmax
%         for s = 1:P.Mmax
%             for t = 1:P.Pmax
%                 Vmatrix((s-1)*P.Pmax+t, 1) = V(s, t, P);
%                 in((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = Hz_in_proj(m, p, s, t, P);
%                 out((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = Hz_out_proj(m, p, s, t, P);
%                 Zmatrix((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) = in((s-1)*P.Pmax+t, (m-1)*P.Pmax+p) - out((s-1)*P.Pmax+t, (m-1)*P.Pmax+p);
%             end
%         end
%     end
% end
% dMatrix = Zmatrix\Vmatrix;
% z_in_f(P)+z_in_m(dMatrix, Vmatrix, P)