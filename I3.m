function r = I3(n, m) %eq 62 ok
    global Mspace delta_phi phi1
    phi_1m = Mspace(m);
    phi_2m = Mspace(m+1);
    if n == 0
        r = phi2m-phi1m;
    else
        r = delta_phi/(n*pi)*(sin(n*pi/delta_phi*(phi_2m-phi1))-sin(n*pi/delta_phi*(phi_1m-phi1)));
    end
end