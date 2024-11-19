function r = dJ(ni, x) %derivative of bessel function of the first kind
    r = (ni*besselj(ni, x))/x - besselj(ni + 1, x);
end