function r = c_besselj(ni,x)
    if imag(x) == 0
        r = real(besselj(ni, x));
    elseif real(x) == 0
        cu = -imag(x);
        civ = real(besseli(ni, cu));
        r = ((-1j)^ni)*civ;
    else
        r = besselj(ni, x);
    end
end