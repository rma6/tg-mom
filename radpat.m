function Ephis = radpat(dMat, P)
    Ephis = [];
    Ethetas = [];
    theta = pi/2-pi/1000;
    for phi=-180:180
        [Etheta, Ephi] = Efields(theta, phi*pi/180, dMat, P);
        Ephis(end+1) = abs(Ephi);
        Ethetas(end+1) = abs(Etheta);
    end

    figure
    polarpattern(-180:180, Ephis, TitleTopTextInterpreter="tex", TitleTop = "E_{\phi} @ \theta=90"+char(176))

    figure
    polarpattern(-180:180, Ethetas, TitleTopTextInterpreter="tex", TitleTop = "E_{\theta} @ \theta=90"+char(176))

    Ephis = [];
    Ethetas = [];
    phi = (P.phi1+P.phi2)/2;
    for theta=-180:180
        [Etheta, Ephi] = Efields(theta*pi/180, phi, dMat, P);
        Ephis(end+1) = abs(Ephi);
        Ethetas(end+1) = abs(Etheta);
    end

    figure
    polarpattern(-180:180, Ephis, TitleTopTextInterpreter="tex", TitleTop = "E_{\phi} @ \phi=0"+char(176))

    figure
    polarpattern(-180:180, Ethetas, TitleTopTextInterpreter="tex", TitleTop = "E_{\theta} @ \phi=0"+char(176))

%     Ephis = [];
%     Ethetas = [];
%     phi = (P.phi1+P.phi2)/2-pi;
%     for theta=179:-1:1
%         [Etheta, Ephi] = Efields(theta*pi/180, phi, dMat, P);
%         Ephis(end+1) = abs(Ephi);
%         Ethetas(end+1) = abs(Etheta);
%     end
%     phi = (P.phi1+P.phi2)/2;
%     for theta=1:179
%         [Etheta, Ephi] = Efields(theta*pi/180, phi, dMat, P);
%         Ephis(end+1) = abs(Ephi);
%         Ethetas(end+1) = abs(Etheta);
%     end
% 
%     figure
%     polarpattern(cat(2, -1*(179:-1:1), 1:179), Ephis, TitleTopTextInterpreter="tex", TitleTop = "E_{\phi} @ \phi=0"+char(176))
% 
%     figure
%     polarpattern(cat(2, -1*(179:-1:1), 1:179), Ethetas, TitleTopTextInterpreter="tex", TitleTop = "E_{\theta} @ \phi=0"+char(176))
end