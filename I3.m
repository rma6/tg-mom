function r = I3(n, m) %eq 62 ok
    P = params();
    
    phi_1m = P.Mspace(m);
    phi_2m = P.Mspace(m+1);
    
    if n == 0
        r = phi_2m-phi_1m;
    else
        r = P.delta_phi/(n*pi)*(sin(n*pi/P.delta_phi*(phi_2m-P.phi1))-sin(n*pi/P.delta_phi*(phi_1m-P.phi1)));
    end
end