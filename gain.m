function G = gain(field, power, P)
    U = abs(field)^2/(2*P.eta_0);
    G = 4*pi*U/power;
end