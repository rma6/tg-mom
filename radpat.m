function [Gphi0_db, Gtheta90_db] = radpat(dMat, peak_power, P)

    Gphi0 = zeros(361, 3);
    [Etheta, Ephi] = Efields(pi/1000, pi-pi/1000, dMat, P);
    Gphi0(1,:) = [0, gain(Etheta, peak_power, P), gain(Ephi, peak_power, P)];
    Gphi0(361,:) = [360, gain(Etheta, peak_power, P), gain(Ephi, peak_power, P)];
    parfor theta=1:179
        [Etheta, Ephi] = Efields(theta*pi/180, pi/1000, dMat, P);
        Gphi0(theta+1,:) = [theta, gain(Etheta, peak_power, P), gain(Ephi, peak_power, P)];
    end
    [Etheta, Ephi] = Efields(180-pi/1000, pi-pi/1000, dMat, P);
    Gphi0(181,:) = [180, gain(Etheta, peak_power, P), gain(Ephi, peak_power, P)];
    parfor theta=1:179
        [Etheta, Ephi] = Efields(theta*pi/180, pi-pi/1000, dMat, P);
        Gphi0(theta+181,:) = [theta+180, gain(Etheta, peak_power, P), gain(Ephi, peak_power, P)];
    end
    [~, Ephi] = Efields(90*pi/180+pi/1000, pi/1000, dMat, P);
    Gphi0(91,3) = gain(Ephi, peak_power, P);
    [~, Ephi] = Efields(90*pi/180+pi/1000, pi-pi/1000, dMat, P);
    Gphi0(271,3) = gain(Ephi, peak_power, P);

    Gtheta90 = zeros(361, 3);
    parfor phi=0:360
        [Etheta, Ephi] = Efields(pi/2-pi/1000, phi*pi/180, dMat, P);
        Gtheta90(phi+1,:) = [phi, gain(Etheta, peak_power, P), gain(Ephi, peak_power, P)];
    end
    [~, Ephi] = Efields(pi/2-pi/1000, pi/1000, dMat, P);
    Gtheta90(1,3) = gain(Ephi, peak_power, P);
    [~, Ephi] = Efields(pi/2-pi/1000, 180*pi/180+pi/1000, dMat, P);
    Gtheta90(181,3) = gain(Ephi, peak_power, P);
    Gtheta90(361,3) = Gtheta90(1,3);

    Gphi0_db = Gphi0;
    Gphi0_db(:,2) = 10*log10(Gphi0_db(:,2));
%     Gphi0_db(:,2) = Gphi0_db(:,2)-max(Gphi0_db(:,2));
    Gphi0_db(:,3) = 10*log10(Gphi0_db(:,3));
%     Gphi0_db(:,3) = Gphi0_db(:,3)-max(Gphi0_db(:,3));
    
    Gtheta90_db = Gtheta90;
    Gtheta90_db(:,2) = 10*log10(Gtheta90_db(:,2));
%     Gtheta90_db(:,2) = Gtheta90_db(:,2)-max(Gtheta90_db(:,2));
    Gtheta90_db(:,3) = 10*log10(Gtheta90_db(:,3));
%     Gtheta90_db(:,3) = Gtheta90_db(:,3)-max(Gtheta90_db(:,3));

    figure('Name','gain_theta@phi=0'); polarpattern(Gphi0_db(:,1), Gphi0_db(:,2), TitleTopTextInterpreter="tex", TitleTop = "E_{\theta} @ \phi=0"+char(176))
    figure('Name','gain_phi@phi=0'); polarpattern(Gphi0_db(:,1), Gphi0_db(:,3), TitleTopTextInterpreter="tex", TitleTop = "E_{\phi} @ \phi=0"+char(176))
    figure('Name','gain_theta@theta=90'); polarpattern(Gtheta90_db(:,1), Gtheta90_db(:,2), TitleTopTextInterpreter="tex", TitleTop = "E_{\theta} @ \theta=90"+char(176))
    figure('Name','gain_phi@theta=90'); polarpattern(Gtheta90_db(:,1), Gtheta90_db(:,3), TitleTopTextInterpreter="tex", TitleTop = "E_{\phi} @ \theta=90"+char(176))
end
