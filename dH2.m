function r = dH2(ni, x) %derivative of hankel function of the second kind
    r = (ni.*besselh(ni, 2, x))./x - besselh(ni + 1, 2, x);
end
%ok?