function G = gain(field, peak_power, P)
        U = abs(field)^2/(2*P.eta_0);
        G = U*4*pi/peak_power;
end