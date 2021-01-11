function [F] = coh_loss(T, l, t, e, operation, g, sigma)
warning('off')

switch operation
    case 'epr'
        % send mode B
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^((1/2).*r.*(2.*exp(1).^((sqrt(-1)*(-1)).*theta).*((-1)+g) ...
            .*ra+(-2).*exp(1).^(sqrt(-1).*theta).*((-1)+g).*ra+((-1)+l.^2).^( ...
            -1).*r.*(2+g.^2.*(2+2.*l.^2.*((-1)+t)+e.*((-1)+l.^2).*((-1)+t))+( ...
            -4).*g.*l.*t.^(1/2)))).*pi.^(-1).*r)...
            ,0,inf,0,2*pi,0,3*sigma);
    case 'ps'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^(r.*(exp(1).^((sqrt(-1)*(-1)).*theta).*((-1)+g).*ra+(-1).* ...
            exp(1).^(sqrt(-1).*theta).*((-1)+g).*ra+r.*((-2)+g.^2.*((-2)+(-1) ...
            .*e.*t+l.^2.*(2+((-2)+e).*t))+e.*t.*((-1)+T)+4.*g.*l.*t.^(1/2).* ...
            T.^(1/2)).*(2+l.^2.*((-2)+((-2)+e).*t.*((-1)+T))+e.*(t+(-1).*t.*T) ...
            ).^(-1))).*((-2).*l.^2+e.*((-1)+l.^2)).^(-1).*pi.^(-1).*r.*(2+ ...
            l.^2.*((-2)+((-2)+e).*t.*((-1)+T))+e.*(t+(-1).*t.*T)).^(-1).*( ...
            e.^2.*((-1)+l.^2).^2.*t.*((-1)+T+g.^2.*r.^2.*T)+4.*l.^2.*((-1)+ ...
            r.^2+(-2).*g.*l.*r.^2.*t.^(1/2).*T.^(1/2)+l.^2.*(1+t.*((-1)+T+ ...
            g.^2.*r.^2.*T)))+(-2).*e.*((-1)+l.^2).*((-1)+(-2).*g.*l.*r.^2.* ...
            t.^(1/2).*T.^(1/2)+l.^2.*(1+2.*t.*((-1)+T+g.^2.*r.^2.*T)))))...
            ,0,inf,0,2*pi,0,3*sigma);
    case 'pa'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^(r.*(exp(1).^((sqrt(-1)*(-1)).*theta).*((-1)+g).*ra+(-1).* ...
            exp(1).^(sqrt(-1).*theta).*((-1)+g).*ra+r.*((-2)+g.^2.*((-2)+(-1) ...
            .*e.*t+l.^2.*(2+((-2)+e).*t))+e.*t.*((-1)+T)+4.*g.*l.*t.^(1/2).* ...
            T.^(1/2)).*(2+l.^2.*((-2)+((-2)+e).*t.*((-1)+T))+e.*(t+(-1).*t.*T) ...
            ).^(-1))).*pi.^(-1).*r.*((-2)+(-1).*e.*t+l.^2.*(2+((-2)+e).*t)).^( ...
            -1).*(2+l.^2.*((-2)+((-2)+e).*t.*((-1)+T))+e.*(t+(-1).*t.*T)).^( ...
            -1).*(l.^4.*(2+((-2)+e).*t).*((-2)+g.^2.*r.^2.*(2+((-2)+e).*t)+(( ...
            -2)+e).*t.*((-1)+T))+(2+e.*t).*((-2)+g.^2.*r.^2.*(2+e.*t)+e.*t.*(( ...
            -1)+T))+4.*g.*l.^3.*r.^2.*t.^(1/2).*(2+((-2)+e).*t).*T.^(1/2)+(-4) ...
            .*g.*l.*r.^2.*t.^(1/2).*(2+e.*t).*T.^(1/2)+l.^2.*(8+(-2).*g.^2.* ...
            r.^2.*(4+4.*((-1)+e).*t+((-2)+e).*e.*t.^2)+(-2).*((-2)+e).*e.* ...
            t.^2.*((-1)+T)+4.*t.*((-2)+2.*e+T+(-1).*e.*T+r.^2.*T))))...
            ,0,inf,0,2*pi,0,3*sigma);
    case 'pc'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^(r.*(exp(1).^((sqrt(-1)*(-1)).*theta).*((-1)+g).*ra+(-1).* ...
            exp(1).^(sqrt(-1).*theta).*((-1)+g).*ra+r.*((-2)+g.^2.*((-2)+(-1) ...
            .*e.*t+l.^2.*(2+((-2)+e).*t))+e.*t.*((-1)+T)+4.*g.*l.*t.^(1/2).* ...
            T.^(1/2)).*(2+l.^2.*((-2)+((-2)+e).*t.*((-1)+T))+e.*(t+(-1).*t.*T) ...
            ).^(-1))).*pi.^(-1).*r.*(2+l.^2.*((-2)+((-2)+e).*t.*((-1)+T))+e.*( ...
            t+(-1).*t.*T)).^(-2).*(e.^2.*((-1)+l.^2).^2.*t.^2.*((-1)+T).^2+( ...
            -2).*e.*((-1)+l.^2).*t.*(1+l.^2.*((-1)+2.*t)).*((-1)+T).^2+4.*( ...
            l.^2.*(t.*((-1)+T).^2+(-2).*T)+T+l.^4.*((-1).*t.*((-1)+T).^2+ ...
            t.^2.*((-1)+T).^2+T))).^(-1).*(e.^4.*((-1)+l.^2).^4.*t.^4.*((-1)+ ...
            T).^2.*(((-1)+T).^2+g.^4.*r.^4.*T+g.^2.*r.^2.*((-1)+T.^2))+(-2).* ...
            e.^3.*((-1)+l.^2).^3.*t.^3.*((-1)+T).^2.*(3+(-4).*T+2.*g.^4.* ...
            r.^4.*T+T.^2+g.^2.*r.^2.*((-3)+2.*T+T.^2)+(-2).*g.*l.*r.^2.*t.^( ...
            1/2).*T.^(1/2).*(2.*((-1)+T)+g.^2.*r.^2.*(1+T))+l.^2.*((3+4.*t.*(( ...
            -1)+T)+(-1).*T).*((-1)+T)+2.*g.^4.*r.^4.*((-1)+2.*t).*T+g.^2.* ...
            r.^2.*((-1)+T).*((-3)+(-1).*T+4.*t.*(1+T))))+4.*e.^2.*((-1)+l.^2) ...
            .^2.*t.^2.*((-1)+T).*((-3)+3.*g.^2.*r.^2+4.*T+(-7).*g.^2.*r.^2.*T+ ...
            (-1).*g.^4.*r.^4.*T+(-1).*T.^2+2.*g.^2.*r.^2.*T.^2+g.^4.*r.^4.* ...
            T.^2+(-2).*g.*l.*r.^2.*t.^(1/2).*((-1)+T).*T.^(1/2).*(3.*((-1)+T)+ ...
            g.^2.*r.^2.*(2+T))+(-2).*g.*l.^3.*r.^2.*t.^(1/2).*((-1)+T).*T.^( ...
            1/2).*(3.*((-1)+2.*t).*((-1)+T)+g.^2.*r.^2.*((-2)+(-1).*T+3.*t.*( ...
            1+T)))+l.^4.*(g.^4.*r.^4.*(1+(-6).*t+6.*t.^2).*((-1)+T).*T+g.^2.* ...
            r.^2.*(3+(-7).*T+2.*T.^2+6.*t.^2.*((-1)+T).^2.*(1+T)+(-3).*t.*(( ...
            -1)+T).^2.*(3+T))+((-1)+T).*(3+6.*t.^2.*((-1)+T).^2+(-1).*T+(-3).* ...
            t.*(3+(-4).*T+T.^2)))+l.^2.*(2.*g.^4.*r.^4.*((-1)+3.*t).*((-1)+T) ...
            .*T+((-1)+T).*(2.*((-3)+T)+t.*((-1)+T).*(3.*((-3)+T)+r.^2.*(1+T))) ...
            +g.^2.*r.^2.*((-6)+14.*T+(-4).*T.^2+t.*((-1)+T).*(3.*((-3)+2.*T+ ...
            T.^2)+r.^2.*(1+4.*T+T.^2)))))+16.*(2.*g.*l.*r.^2.*t.^(1/2).*((-1)+ ...
            T).*T.^(1/2)+T+(-2).*g.*l.^3.*r.^2.*t.^(1/2).*((-1)+T).*T.^(1/2).* ...
            (3+(1+g.^2).*r.^2.*t.*((-1)+T)+(-2).*t.*T)+(-2).*g.*l.^7.*r.^2.* ...
            t.^(1/2).*((-1)+T).*T.^(1/2).*(1+(-3).*t.^2.*((-1)+T).^2+2.*t.^3.* ...
            ((-1)+T).^2+(-2).*t.*T+g.^2.*r.^2.*((-1)+t).*t.*((-1)+T).*((-1)+t+ ...
            t.*T))+l.^2.*((-4).*T+t.*((-1)+T).*((-1)+g.^2.*r.^4.*((-1)+T)+(-1) ...
            .*T+(-1).*(1+g.^2).*r.^2.*((-1)+3.*T)))+l.^8.*(T+t.*((-1)+T).*(1+ ...
            T+g.^2.*r.^2.*((-1)+3.*T))+t.^4.*((-1)+T).^2.*(((-1)+T).^2+g.^4.* ...
            r.^4.*T+g.^2.*r.^2.*((-1)+T.^2))+(-1).*t.^3.*((-1)+T).^2.*(3+(-4) ...
            .*T+2.*g.^4.*r.^4.*T+T.^2+g.^2.*r.^2.*((-3)+2.*T+T.^2))+t.^2.*(( ...
            -1).*((-3)+T).*((-1)+T).^2+g.^4.*r.^4.*((-1)+T).^2.*T+g.^2.*r.^2.* ...
            ((-3)+10.*T+(-9).*T.^2+2.*T.^3)))+(-2).*g.*l.^5.*r.^2.*t.^(1/2).*( ...
            (-1)+T).*T.^(1/2).*((-3)+3.*t.^2+4.*t.*T+(-6).*t.^2.*T+3.*t.^2.* ...
            T.^2+r.^2.*t.*((-1)+T).*((-1)+t+t.*T+g.^2.*((-2)+t.*(2+T))))+ ...
            l.^6.*((-4).*T+t.*((-1)+T).*(g.^2.*r.^4.*((-1)+T)+(-3).*(1+T)+(-1) ...
            .*(1+3.*g.^2).*r.^2.*((-1)+3.*T))+t.^3.*((-1)+T).^2.*(3+(-4).*T+ ...
            T.^2+g.^2.*r.^4.*(1+2.*(2+g.^2).*T+T.^2)+r.^2.*((-1)+T).*(1+T+ ...
            g.^2.*(3+T)))+(-2).*t.^2.*((-1)+T).*((-3)+4.*T+(-1).*T.^2+g.^2.* ...
            r.^4.*((-1)+T).*(1+(2+g.^2).*T)+r.^2.*(((-1)+T).^2+g.^2.*(3+(-7).* ...
            T+2.*T.^2))))+l.^4.*(6.*T+(-1).*t.*((-1)+T).*(2.*g.^2.*r.^4.*((-1) ...
            +T)+(-3).*(1+T)+(-1).*(2+3.*g.^2).*r.^2.*((-1)+3.*T))+t.^2.*((-1)+ ...
            T).*((-1).*((-3)+T).*((-1)+T)+r.^4.*((-1)+T).*(T+g.^4.*T+g.^2.*(2+ ...
            4.*T))+r.^2.*(2.*((-1)+T).^2+g.^2.*(3+(-7).*T+2.*T.^2)))))+(-8).* ...
            e.*((-1)+l.^2).*t.*((-1)+T).*((-1)+g.^2.*r.^2+(-1).*T+(-3).*g.^2.* ...
            r.^2.*T+2.*g.*l.*r.^2.*t.^(1/2).*T.^(1/2).*((-1).*g.^2.*r.^2.*(( ...
            -1)+T)+2.*T)+(-2).*g.*l.^5.*r.^2.*t.^(1/2).*T.^(1/2).*(2.*((-3).* ...
            t.*((-1)+T).^2+3.*t.^2.*((-1)+T).^2+(-1).*T)+g.^2.*r.^2.*((-1)+T) ...
            .*(1+3.*t.^2.*(1+T)+(-2).*t.*(2+T)))+(-2).*g.*l.^3.*r.^2.*t.^(1/2) ...
            .*T.^(1/2).*(4.*T+t.*((-1)+T).*((-6)+r.^2+6.*T+r.^2.*T)+2.*g.^2.* ...
            r.^2.*((-1)+T).*((-1)+t.*(2+T)))+l.^6.*(1+(-3).*t.^2.*((-3)+T).*(( ...
            -1)+T).^2+4.*t.^3.*((-1)+T).^3+T+2.*g.^4.*r.^4.*t.*(1+(-3).*t+2.* ...
            t.^2).*((-1)+T).*T+(-2).*t.*(3+(-4).*T+T.^2)+g.^2.*r.^2.*((-1)+3.* ...
            T+4.*t.^3.*((-1)+T).^2.*(1+T)+(-3).*t.^2.*((-1)+T).^2.*(3+T)+2.* ...
            t.*(3+(-7).*T+2.*T.^2)))+l.^4.*((-2).*t.*(6+r.^2.*((-1)+T)+(-2).* ...
            T).*((-1)+T)+2.*g.^4.*r.^4.*t.*((-2)+3.*t).*((-1)+T).*T+(-3).*(1+ ...
            T)+t.^2.*((-1)+T).^2.*(3.*((-3)+T)+2.*r.^2.*(1+T))+g.^2.*r.^2.*(3+ ...
            (-9).*T+2.*t.*((-6)+14.*T+(-4).*T.^2+r.^2.*(1+T+(-2).*T.^2))+ ...
            t.^2.*((-1)+T).*(3.*((-3)+2.*T+T.^2)+2.*r.^2.*(1+4.*T+T.^2))))+ ...
            l.^2.*(2.*t.*(3+r.^2.*((-1)+T)+(-1).*T).*((-1)+T)+2.*g.^4.*r.^4.* ...
            t.*((-1)+T).*T+3.*(1+T)+g.^2.*r.^2.*((-3)+9.*T+2.*t.*(3+(-7).*T+ ...
            2.*T.^2+r.^2.*((-1)+(-1).*T+2.*T.^2)))))))...
            ,0,inf,0,2*pi,0,3*sigma);
        
    case 'sa'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^(r.*(exp(1).^((sqrt(-1)*(-1)).*theta).*((-1)+g).*ra+(-1).* ...
            exp(1).^(sqrt(-1).*theta).*((-1)+g).*ra+r.*((-2)+g.^2.*((-2)+(-1) ...
            .*e.*t+l.^2.*(2+((-2)+e).*t))+4.*g.*l.*t.^(1/2).*T+e.*t.*((-1)+ ...
            T.^2)).*(2+e.*(t+(-1).*t.*T.^2)+l.^2.*((-2)+((-2)+e).*t.*((-1)+ ...
            T.^2))).^(-1))).*((-2).*l.^2+e.*((-1)+l.^2)).^(-1).*pi.^(-1).*r.*( ...
            2+e.*(t+(-1).*t.*T.^2)+l.^2.*((-2)+((-2)+e).*t.*((-1)+T.^2))).^( ...
            -2).*((-2)+(-1).*e.*t.*(1+T.^2)+l.^2.*(2+((-2)+e).*t.*(1+T.^2))) ...
            .^(-1).*(e.^4.*((-1)+l.^2).^4.*t.^3.*(g.^4.*r.^4.*T.^2+((-1)+T.^2) ...
            .^2.*(1+T.^2)+g.^2.*r.^2.*((-1)+(-2).*T.^2+3.*T.^4))+(-2).*e.^3.*( ...
            (-1)+l.^2).^3.*t.^2.*(3+(-2).*T.^2+2.*g.^4.*r.^4.*T.^2+(-1).*T.^4+ ...
            g.^2.*r.^2.*((-3)+(-4).*T.^2+3.*T.^4)+(-2).*g.*l.*r.^2.*t.^(1/2).* ...
            T.*((-3)+2.*T.^2+T.^4+g.^2.*r.^2.*(1+T.^2))+l.^2.*(2.*g.^4.*r.^4.* ...
            ((-1)+2.*t).*T.^2+((-1)+T.^2).*(3+T.^2+4.*t.*((-1)+T.^4))+g.^2.* ...
            r.^2.*(3+4.*T.^2+(-3).*T.^4+4.*t.*((-1)+(-2).*T.^2+3.*T.^4))))+4.* ...
            e.^2.*((-1)+l.^2).^2.*t.*(3+(-3).*g.^2.*r.^2+(-1).*T.^2+(-2).* ...
            g.^2.*r.^2.*T.^2+g.^4.*r.^4.*T.^2+(-2).*g.*l.*r.^2.*t.^(1/2).*T.*( ...
            2.*((-3)+T.^2)+g.^2.*r.^2.*(2+T.^2))+(-2).*g.*l.^3.*r.^2.*t.^(1/2) ...
            .*T.*(6+(-2).*T.^2+3.*t.*((-3)+2.*T.^2+T.^4)+g.^2.*r.^2.*((-2)+( ...
            -1).*T.^2+3.*t.*(1+T.^2)))+l.^4.*(3+(-1).*T.^2+g.^4.*r.^4.*(1+(-6) ...
            .*t+6.*t.^2).*T.^2+6.*t.^2.*((-1)+T.^2).^2.*(1+T.^2)+3.*t.*((-3)+ ...
            2.*T.^2+T.^4)+g.^2.*r.^2.*((-3)+(-2).*T.^2+t.*(9+12.*T.^2+(-9).* ...
            T.^4)+6.*t.^2.*((-1)+(-2).*T.^2+3.*T.^4)))+l.^2.*(2.*g.^4.*r.^4.*( ...
            (-1)+3.*t).*T.^2+2.*((-3)+T.^2)+t.*((-1)+T.^2).*((-9)+r.^2+(-3).* ...
            T.^2+3.*r.^2.*T.^2)+g.^2.*r.^2.*(6+4.*T.^2+t.*((-9)+(-12).*T.^2+ ...
            9.*T.^4+r.^2.*(1+4.*T.^2+T.^4)))))+(-8).*e.*((-1)+l.^2).*(1+(-1).* ...
            g.^2.*r.^2+(-2).*g.*l.*r.^2.*((-3)+g.^2.*r.^2).*t.^(1/2).*T+(-2).* ...
            g.*l.^5.*r.^2.*t.^(1/2).*T.*((-3)+(-4).*t.*((-3)+T.^2)+3.*t.^2.*(( ...
            -3)+2.*T.^2+T.^4)+g.^2.*r.^2.*(1+3.*t.^2.*(1+T.^2)+(-2).*t.*(2+ ...
            T.^2)))+(-2).*g.*l.^3.*r.^2.*t.^(1/2).*T.*(6+4.*t.*((-3)+T.^2)+ ...
            r.^2.*t.*(1+T.^2)+2.*g.^2.*r.^2.*((-1)+t.*(2+T.^2)))+l.^2.*((-3)+ ...
            2.*g.^4.*r.^4.*t.*T.^2+(-2).*t.*((-3)+T.^2+r.^2.*(1+T.^2))+g.^2.* ...
            r.^2.*(3+2.*t.*((-3)+r.^2+(-2).*T.^2+2.*r.^2.*T.^2)))+l.^6.*((-1)+ ...
            2.*g.^4.*r.^4.*t.*(1+(-3).*t+2.*t.^2).*T.^2+(-2).*t.*((-3)+T.^2)+ ...
            4.*t.^3.*((-1)+T.^2).^2.*(1+T.^2)+3.*t.^2.*((-3)+2.*T.^2+T.^4)+ ...
            g.^2.*r.^2.*(1+(-2).*t.*(3+2.*T.^2)+t.^2.*(9+12.*T.^2+(-9).*T.^4)+ ...
            4.*t.^3.*((-1)+(-2).*T.^2+3.*T.^4)))+l.^4.*(3+2.*g.^4.*r.^4.*t.*(( ...
            -2)+3.*t).*T.^2+2.*t.*(2.*((-3)+T.^2)+r.^2.*(1+T.^2))+t.^2.*((-1)+ ...
            T.^2).*((-3).*(3+T.^2)+r.^2.*(2+6.*T.^2))+g.^2.*r.^2.*((-3)+(-2).* ...
            t.*((-6)+(-4).*T.^2+r.^2.*(1+2.*T.^2))+t.^2.*((-9)+(-12).*T.^2+9.* ...
            T.^4+2.*r.^2.*(1+4.*T.^2+T.^4)))))+16.*l.^2.*(((-1)+r.^2).*((-1)+ ...
            g.^2.*r.^2)+(-2).*g.*l.*r.^2.*((-3)+(1+g.^2).*r.^2).*t.^(1/2).*T+( ...
            -2).*g.*l.^5.*r.^2.*t.^(1/2).*T.*((-3)+(-2).*t.*((-3)+T.^2)+t.^2.* ...
            ((-3)+2.*T.^2+T.^4)+g.^2.*r.^2.*(1+t.^2.*(1+T.^2)+(-1).*t.*(2+ ...
            T.^2)))+l.^2.*((-3)+(-1).*t.*((-3)+T.^2)+r.^4.*(t.*T.^2+g.^4.*t.* ...
            T.^2+2.*g.^2.*((-1)+t+2.*t.*T.^2))+(-1).*r.^2.*(2.*((-1)+t+t.* ...
            T.^2)+g.^2.*((-3)+3.*t+2.*t.*T.^2)))+l.^6.*(g.^4.*r.^4.*((-1)+t) ...
            .^2.*t.*T.^2+((-1)+t+t.*T.^2).*(1+t.*((-1)+T.^2)).^2+g.^2.*r.^2.*( ...
            1+(-1).*t.*(3+2.*T.^2)+t.^2.*(3+4.*T.^2+(-3).*T.^4)+t.^3.*((-1)+( ...
            -2).*T.^2+3.*T.^4)))+(-2).*g.*l.^3.*r.^2.*t.^(1/2).*T.*(6+2.*t.*(( ...
            -3)+T.^2)+r.^2.*((-1)+t+t.*T.^2+g.^2.*((-2)+t.*(2+T.^2))))+l.^4.*( ...
            3+2.*t.*((-3)+T.^2)+(-1).*t.^2.*((-3)+2.*T.^2+T.^4)+g.^2.*r.^4.*( ...
            1+(-2).*t.*(1+(2+g.^2).*T.^2)+t.^2.*(1+2.*(2+g.^2).*T.^2+T.^4))+ ...
            r.^2.*((-1)+2.*t.*(1+T.^2)+t.^2.*((-1)+(-2).*T.^2+3.*T.^4)+g.^2.*( ...
            (-3)+t.*(6+4.*T.^2)+t.^2.*((-3)+(-4).*T.^2+3.*T.^4)))))))...
            ,0,inf,0,2*pi,0,3*sigma);
        
    case 'as'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^(r.*(exp(1).^((sqrt(-1)*(-1)).*theta).*((-1)+g).*ra+(-1).* ...
            exp(1).^(sqrt(-1).*theta).*((-1)+g).*ra+r.*((-2)+g.^2.*((-2)+(-1) ...
            .*e.*t+l.^2.*(2+((-2)+e).*t))+4.*g.*l.*t.^(1/2).*T+e.*t.*((-1)+ ...
            T.^2)).*(2+e.*(t+(-1).*t.*T.^2)+l.^2.*((-2)+((-2)+e).*t.*((-1)+ ...
            T.^2))).^(-1))).*pi.^(-1).*r.*((-2)+(-1).*e.*t+l.^2.*(2+((-2)+e).* ...
            t)).^(-1).*(2+e.*(t+(-1).*t.*T.^2)+l.^2.*((-2)+((-2)+e).*t.*((-1)+ ...
            T.^2))).^(-2).*((-2)+(-1).*e.*t.*(1+T.^2)+l.^2.*(2+((-2)+e).*t.*( ...
            1+T.^2))).^(-1).*(16+(-8).*e.*t.*((-4)+(1+3.*g.^2.*r.^2).*T.^2)+ ...
            4.*e.^2.*t.^2.*(6+(-3).*(1+3.*g.^2.*r.^2).*T.^2+((-1)+2.*g.^2.* ...
            r.^2+g.^4.*r.^4).*T.^4)+e.^4.*t.^4.*(1+(-1).*(1+3.*g.^2.*r.^2).* ...
            T.^2+((-1)+2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4+(1+g.^2.*r.^2).*T.^6)+ ...
            2.*e.^3.*t.^3.*(4+(-3).*(1+3.*g.^2.*r.^2).*T.^2+2.*((-1)+2.*g.^2.* ...
            r.^2+g.^4.*r.^4).*T.^4+(1+g.^2.*r.^2).*T.^6)+4.*g.*l.^7.*r.^2.* ...
            t.^(1/2).*(2+((-2)+e).*t).*T.*((-4)+2.*((-2)+e).*t.*((-2)+((-2)+ ...
            g.^2.*r.^2).*T.^2)+((-2)+e).^2.*t.^2.*((-1)+((-2)+g.^2.*r.^2).* ...
            T.^2+(3+g.^2.*r.^2).*T.^4))+(-4).*g.*l.*r.^2.*t.^(1/2).*(2+e.*t).* ...
            T.*((-4)+2.*e.*t.*((-2)+((-2)+g.^2.*r.^2).*T.^2)+e.^2.*t.^2.*((-1) ...
            +((-2)+g.^2.*r.^2).*T.^2+(3+g.^2.*r.^2).*T.^4))+l.^8.*(16+(-8).*(( ...
            -2)+e).*t.*((-4)+(1+3.*g.^2.*r.^2).*T.^2)+4.*((-2)+e).^2.*t.^2.*( ...
            6+(-3).*(1+3.*g.^2.*r.^2).*T.^2+((-1)+2.*g.^2.*r.^2+g.^4.*r.^4).* ...
            T.^4)+((-2)+e).^4.*t.^4.*(1+(-1).*(1+3.*g.^2.*r.^2).*T.^2+((-1)+ ...
            2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4+(1+g.^2.*r.^2).*T.^6)+2.*((-2)+e) ...
            .^3.*t.^3.*(4+(-3).*(1+3.*g.^2.*r.^2).*T.^2+2.*((-1)+2.*g.^2.* ...
            r.^2+g.^4.*r.^4).*T.^4+(1+g.^2.*r.^2).*T.^6))+4.*g.*l.^3.*r.^2.* ...
            t.^(1/2).*T.*((-24)+3.*((-2)+e).*e.^2.*t.^3.*((-1)+((-2)+g.^2.* ...
            r.^2).*T.^2+(3+g.^2.*r.^2).*T.^4)+4.*t.*(6+(-2).*((-2)+(1+g.^2).* ...
            r.^2).*T.^2+3.*e.*((-3)+((-2)+g.^2.*r.^2).*T.^2))+2.*e.*t.^2.*(3.* ...
            e.*((-3)+2.*((-2)+g.^2.*r.^2).*T.^2+(3+g.^2.*r.^2).*T.^4)+(-2).*(( ...
            -6)+((-8)+r.^2+4.*g.^2.*r.^2).*T.^2+(6+r.^2+2.*g.^2.*r.^2).*T.^4)) ...
            )+(-4).*g.*l.^5.*r.^2.*t.^(1/2).*T.*((-24)+3.*((-2)+e).^2.*e.* ...
            t.^3.*((-1)+((-2)+g.^2.*r.^2).*T.^2+(3+g.^2.*r.^2).*T.^4)+4.*t.*( ...
            12+(-2).*((-4)+r.^2+2.*g.^2.*r.^2).*T.^2+3.*e.*((-3)+((-2)+g.^2.* ...
            r.^2).*T.^2))+2.*t.^2.*(3.*e.^2.*((-3)+2.*((-2)+g.^2.*r.^2).*T.^2+ ...
            (3+g.^2.*r.^2).*T.^4)+(-2).*e.*((-12)+((-16)+r.^2+8.*g.^2.*r.^2).* ...
            T.^2+(12+r.^2+4.*g.^2.*r.^2).*T.^4)+4.*((-3)+((-4)+(1+2.*g.^2).* ...
            r.^2).*T.^2+(3+(1+g.^2).*r.^2).*T.^4)))+(-4).*l.^6.*(16+((-2)+e) ...
            .^3.*e.*t.^4.*(1+(-1).*(1+3.*g.^2.*r.^2).*T.^2+((-1)+2.*g.^2.* ...
            r.^2+g.^4.*r.^4).*T.^4+(1+g.^2.*r.^2).*T.^6)+(-4).*t.*(12+((-3)+( ...
            -3).*(1+3.*g.^2).*r.^2+g.^2.*r.^4).*T.^2+2.*e.*((-4)+(1+3.*g.^2.* ...
            r.^2).*T.^2))+4.*t.^2.*(e.^2.*(6+(-3).*(1+3.*g.^2.*r.^2).*T.^2+(( ...
            -1)+2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4)+2.*(6+((-3)+(-3).*(1+3.*g.^2) ...
            .*r.^2+g.^2.*r.^4).*T.^2+((-1)+(1+2.*g.^2).*r.^2+g.^2.*(2+g.^2).* ...
            r.^4).*T.^4)+(-1).*e.*(18+((-9)+(-3).*(1+9.*g.^2).*r.^2+g.^2.* ...
            r.^4).*T.^2+((-3)+(1+6.*g.^2).*r.^2+g.^2.*(2+3.*g.^2).*r.^4).* ...
            T.^4))+((-2)+e).^2.*t.^3.*((-4)+(3+(3+9.*g.^2).*r.^2+(-1).*g.^2.* ...
            r.^4).*T.^2+(-2).*((-1)+(1+2.*g.^2).*r.^2+g.^2.*(2+g.^2).*r.^4).* ...
            T.^4+(-1).*(1+r.^2).*(1+g.^2.*r.^2).*T.^6+2.*e.*(4+(-3).*(1+3.* ...
            g.^2.*r.^2).*T.^2+2.*((-1)+2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4+(1+ ...
            g.^2.*r.^2).*T.^6)))+(-4).*l.^2.*(16+((-2)+e).*e.^3.*t.^4.*(1+(-1) ...
            .*(1+3.*g.^2.*r.^2).*T.^2+((-1)+2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4+( ...
            1+g.^2.*r.^2).*T.^6)+(-4).*t.*(4+((-1)+(-3).*(1+g.^2).*r.^2+g.^2.* ...
            r.^4).*T.^2+2.*e.*((-4)+(1+3.*g.^2.*r.^2).*T.^2))+4.*e.*t.^2.*(( ...
            -6)+(3+(3+9.*g.^2).*r.^2+(-1).*g.^2.*r.^4).*T.^2+(-1).*((-1)+(1+ ...
            2.*g.^2).*r.^2+g.^2.*(2+g.^2).*r.^4).*T.^4+e.*(6+(-3).*(1+3.* ...
            g.^2.*r.^2).*T.^2+((-1)+2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4))+e.^2.* ...
            t.^3.*((-12)+(9+3.*(1+9.*g.^2).*r.^2+(-1).*g.^2.*r.^4).*T.^2+(-2) ...
            .*((-3)+(1+6.*g.^2).*r.^2+g.^2.*(2+3.*g.^2).*r.^4).*T.^4+(-1).*(3+ ...
            r.^2).*(1+g.^2.*r.^2).*T.^6+2.*e.*(4+(-3).*(1+3.*g.^2.*r.^2).* ...
            T.^2+2.*((-1)+2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4+(1+g.^2.*r.^2).* ...
            T.^6)))+2.*l.^4.*(48+3.*((-2)+e).^2.*e.^2.*t.^4.*(1+(-1).*(1+3.* ...
            g.^2.*r.^2).*T.^2+((-1)+2.*g.^2.*r.^2+g.^4.*r.^4).*T.^4+(1+g.^2.* ...
            r.^2).*T.^6)+(-8).*t.*(12+((-3)+(-3).*(2+3.*g.^2).*r.^2+2.*g.^2.* ...
            r.^4).*T.^2+3.*e.*((-4)+(1+3.*g.^2.*r.^2).*T.^2))+4.*t.^2.*(3.* ...
            e.^2.*(6+(-3).*(1+3.*g.^2.*r.^2).*T.^2+((-1)+2.*g.^2.*r.^2+g.^4.* ...
            r.^4).*T.^4)+(-2).*e.*(18+((-9)+(-3).*(2+9.*g.^2).*r.^2+2.*g.^2.* ...
            r.^4).*T.^2+((-3)+(2+6.*g.^2).*r.^2+g.^2.*(4+3.*g.^2).*r.^4).* ...
            T.^4)+2.*(6+((-3)+(-3).*(2+3.*g.^2).*r.^2+2.*g.^2.*r.^4).*T.^2+(( ...
            -1)+2.*(1+g.^2).*r.^2+(1+4.*g.^2+g.^4).*r.^4).*T.^4))+2.*e.*t.^3.* ...
            (3.*e.^2.*(4+(-3).*(1+3.*g.^2.*r.^2).*T.^2+2.*((-1)+2.*g.^2.*r.^2+ ...
            g.^4.*r.^4).*T.^4+(1+g.^2.*r.^2).*T.^6)+2.*(12+((-9)+(-3).*(2+9.* ...
            g.^2).*r.^2+2.*g.^2.*r.^4).*T.^2+2.*((-3)+(2+6.*g.^2).*r.^2+g.^2.* ...
            (4+3.*g.^2).*r.^4).*T.^4+(3+2.*r.^2).*(1+g.^2.*r.^2).*T.^6)+(-1).* ...
            e.*(36+((-27)+(-3).*(2+27.*g.^2).*r.^2+2.*g.^2.*r.^4).*T.^2+2.*(( ...
            -9)+2.*(1+9.*g.^2).*r.^2+g.^2.*(4+9.*g.^2).*r.^4).*T.^4+(9+2.* ...
            r.^2).*(1+g.^2.*r.^2).*T.^6)))))...
            ,0,inf,0,2*pi,0,3*sigma);
end

F = real(F);

end