function radpat(dMat, P)
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
% 
% 
%     Ephis = [];
%     Ethetas = [];
%     theta = pi/2-pi/1000;
%     for phi=-180:180
%         [Etheta, Ephi] = Efields(theta, phi*pi/180, dMat, P);
%         Ephis(end+1) = abs(Ephi);
%         Ethetas(end+1) = abs(Etheta);
%     end
% 
%     figure
%     polarpattern(-180:180, Ephis, TitleTopTextInterpreter="tex", TitleTop = "E_{\phi} @ \theta=90"+char(176))
% 
%     figure
%     polarpattern(-180:180, Ethetas, TitleTopTextInterpreter="tex", TitleTop = "E_{\theta} @ \theta=90"+char(176))
    M_theta = zeros(0, 3);
    M_phi = zeros(0, 3);
    parfor theta=1:179
        for phi=-179:180
            [Etheta, Ephi] = Efields(theta*pi/180, phi*pi/180, dMat, P);
            M_theta = [M_theta;[abs(Etheta), theta, phi]];
            M_phi = [M_phi;[abs(Ephi), theta, phi]];
        end
    end
    
    figure; patternCustom(M_theta(:,1),M_theta(:,2),M_theta(:,3));
    figure; patternCustom(M_phi(:,1),M_phi(:,2),M_phi(:,3));
    figure; patternCustom(M_theta(:,1),M_theta(:,2),M_theta(:,3), CoordinateSystem="polar", Slice="theta", SliceValue=90);
    figure; patternCustom(M_theta(:,1),M_theta(:,2),M_theta(:,3), CoordinateSystem="polar", Slice="phi", SliceValue=0);
    figure; patternCustom(M_phi(:,1),M_phi(:,2),M_phi(:,3), CoordinateSystem="polar", Slice="theta", SliceValue=90);
    figure; patternCustom(M_phi(:,1),M_phi(:,2),M_phi(:,3), CoordinateSystem="polar", Slice="phi", SliceValue=0);
end