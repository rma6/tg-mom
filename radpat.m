function [M_theta_db, M_phi_db] = radpat(dMat, peak_power, P)
    M_theta = zeros(0, 3);
    M_phi = zeros(0, 3);
    for theta=1:179
        for phi=-179:180
            [Etheta, Ephi] = Efields(theta*pi/180, phi*pi/180, dMat, P);
            M_theta = [M_theta;[abs(Etheta)^2/(2*sqrt(P.mu*P.epsilon_0))*4*pi/peak_power, theta, phi]];
            M_phi = [M_phi;[abs(Ephi)^2/(2*sqrt(P.mu*P.epsilon_0))*4*pi/peak_power, theta, phi]];
%             M_theta = [M_theta;[abs(Etheta), theta, phi]];
%             M_phi = [M_phi;[abs(Ephi), theta, phi]];
        end
    end
    M_theta_db = M_theta;
    M_theta_db(:,1) = 10*log10(M_theta_db(:,1));
    M_theta_db(:,1) = M_theta_db(:,1)-max(M_theta_db(:,1));
    M_phi_db = M_phi;
    M_phi_db(:,1) = 10*log10(M_phi_db(:,1));
    M_phi_db(:,1) = M_phi_db(:,1)-max(M_phi_db(:,1));

    figure('Name','gain_theta'); patternCustom(M_theta_db(:,1),M_theta_db(:,2),M_theta_db(:,3)); title("gain_{\Theta}");
    figure('Name','gain_phi'); patternCustom(M_phi_db(:,1),M_phi_db(:,2),M_phi_db(:,3)); title("gain_{\phi}");
    figure('Name','gain_theta@theta=90'); patternCustom(M_theta_db(:,1),M_theta_db(:,2),M_theta_db(:,3), CoordinateSystem="polar", Slice="theta", SliceValue=90); title(["gain_{\Theta}@\Theta=90" char(176)]);
    figure('Name','gain_theta@phi=0'); patternCustom(M_theta_db(:,1),M_theta_db(:,2),M_theta_db(:,3), CoordinateSystem="polar", Slice="phi", SliceValue=0); title(["gain_{\Theta}@\phi=0" char(176)]);
    figure('Name','gain_phi@theta=90'); patternCustom(M_phi_db(:,1),M_phi_db(:,2),M_phi_db(:,3), CoordinateSystem="polar", Slice="theta", SliceValue=90); title(["gain_{\phi}@\Theta=90" char(176)]);
    figure('Name','gain_phi@phi=0'); patternCustom(M_phi_db(:,1),M_phi_db(:,2),M_phi_db(:,3), CoordinateSystem="polar", Slice="phi", SliceValue=0); title(["gain_{\phi}@\phi=0" char(176)]);
%     figure('Name','E_theta'); patternCustom(M_theta(:,1),M_theta(:,2),M_theta(:,3)); title("E_{\Theta}");
%     figure('Name','E_phi'); patternCustom(M_phi(:,1),M_phi(:,2),M_phi(:,3)); title("E_{\phi}");
%     figure('Name','E_theta@theta=90'); patternCustom(M_theta(:,1),M_theta(:,2),M_theta(:,3), CoordinateSystem="polar", Slice="theta", SliceValue=90); title(["E_{\Theta}@\Theta=90" char(176)]);
%     figure('Name','E_theta@phi=0'); patternCustom(M_theta(:,1),M_theta(:,2),M_theta(:,3), CoordinateSystem="polar", Slice="phi", SliceValue=0); title(["E_{\Theta}@\phi=0" char(176)]);
%     figure('Name','E_phi@theta=90'); patternCustom(M_phi(:,1),M_phi(:,2),M_phi(:,3), CoordinateSystem="polar", Slice="theta", SliceValue=90); title(["E_{\phi}@\Theta=90" char(176)]);
%     figure('Name','E_phi@phi=0'); patternCustom(M_phi(:,1),M_phi(:,2),M_phi(:,3), CoordinateSystem="polar", Slice="phi", SliceValue=0); title(["E_{\phi}@\phi=0" char(176)]);
end