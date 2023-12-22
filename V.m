function r = V(s, t, P) %eq 101
    r = P.delta_phi*P.L/4*summation();

    function acc = summation()
%         Nrmax = 5;
% 	    dr = (P.b-P.a)/Nrmax;
        acc = 0;
        for q = 1:P.its.V.q
            fun = @(rho) ((-q*pi/(1j*P.omega*P.epsilon_d*P.L)*drho_G_Mphi_TAd(rho, s, q, P) + s*pi./(rho*P.delta_phi).*G_Mphi_TFd(rho, s, q, P)).*E(q)/P.L*I3_p(q, t, P).*J_vf_Tss(rho, s, q, P).*rho);
            acc = acc + integral(fun, P.a, P.b);
%             for ir=1:Nrmax
% 		        rmin = P.a + (ir-1.d0)*dr;
% 		        rmax = P.a + ir*dr;
%                 acc = acc + CGQ1(fun,rmin,rmax,16);
%             end
        end
    end
end
%ok