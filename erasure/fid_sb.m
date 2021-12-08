function [F] = fid_sb(V, gx, gp, d, modes, sigma)
warning('off')

switch modes
    case '1'
        % send mode B
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^((-1/8).*r.*(r.*(7+V+gx.^2.*(3+5.*V+(-4).*((-1)+V.^2).^( ...
  1/2))+gx.*(2+(-2).*V+4.*((-1)+V.^2).^(1/2))).*cos(theta).^2+sin( ...
  theta).*((sqrt(-1)*8).*(1+gp).*ra+r.*(7+V+gp.^2.*(3+5.*V+(-4).*(( ...
  -1)+V.^2).^(1/2))+gp.*(2+(-2).*V+4.*((-1)+V.^2).^(1/2))).*sin( ...
  theta)))).*pi.^(-1).*r.*(cos(d).^2+(1/8).*r.^2.*cos(d).*sin(d).*(( ...
  -8).*((-1)+gx).*gx.*V.*cos(theta).^2+((-1)+V.^2).^(1/2).*(2+(-2).* ...
  gp+5.*gp.^2+(-2).*gx+5.*gx.^2+(2.*gp+(-5).*gp.^2+gx.*((-2)+5.*gx)) ...
  .*cos(2.*theta))+(-8).*((-1)+gp).*gp.*V.*sin(theta).^2)+(1/128).* ...
  sin(d).^2.*(128+16.*r.^2.*V.*((-2)+2.*gp+(-5).*gp.^2+2.*gx+(-5).* ...
  gx.^2+((-2).*gp+5.*gp.^2+(2+(-5).*gx).*gx).*cos(2.*theta))+128.* ...
  r.^2.*((-1)+V.^2).^(1/2).*(((-1)+gx).*gx.*cos(theta).^2+((-1)+gp) ...
  .*gp.*sin(theta).^2)+16.*r.^4.*((-1)+3.*V.^2).*(((-1)+gx).^2.* ...
  gx.^2.*cos(theta).^4+((-1)+gp).^2.*gp.^2.*sin(theta).^4)+2.*r.^4.* ...
  ((-1)+V.^2).*(((-1)+gx).^4.*cos(theta).^4+16.*gx.^4.*cos(theta) ...
  .^4+((-1)+gp).^4.*sin(theta).^4+16.*gp.^4.*sin(theta).^4)+16.*(( ...
  -1)+gp).*gp.*((-1)+gx).*gx.*r.^4.*((-1)+V.^2).*sin(2.*theta).^2+(( ...
  (-1)+gp).^2.*((-1)+gx).^2+16.*gp.^2.*gx.^2).*r.^4.*((-1)+V.^2).* ...
  sin(2.*theta).^2+4.*(gx.^2+(-2).*gp.*gx.^2+gp.^2.*(1+(-2).*gx+2.* ...
  gx.^2)).*r.^4.*(1+V.^2).*sin(2.*theta).^2+(-16).*r.^4.*V.*((-1)+ ...
  V.^2).^(1/2).*(gx.*((-1)+3.*gx+(-7).*gx.^2+5.*gx.^3).*cos(theta) ...
  .^4+(((-1)+gx).*gx+gp.^2.*(1+(-3).*gx+6.*gx.^2)+(-1).*gp.*(1+7.* ...
  gx.^2)).*cos(theta).^2.*sin(theta).^2+gp.*(((-1)+3.*gp+(-7).* ...
  gp.^2+5.*gp.^3).*sin(theta).^4+gx.*sin(2.*theta).^2)))))...
            ,0,inf,0,2*pi,0,3*sigma);
    
    case '2'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^((-1/8).*r.*(r.*(7+V+gx.*((-2)+2.*V+(-4).*((-1)+V.^2).^( ...
  1/2))+gx.^2.*(3+5.*V+(-4).*((-1)+V.^2).^(1/2))).*cos(theta).^2+ ...
  sin(theta).*((sqrt(-1)*(-8)).*((-1)+gp).*ra+r.*(7+V+gp.*((-2)+2.* ...
  V+(-4).*((-1)+V.^2).^(1/2))+gp.^2.*(3+5.*V+(-4).*((-1)+V.^2).^( ...
  1/2))).*sin(theta)))).*pi.^(-1).*r.*(cos(d).^2+(1/8).*r.^2.*cos(d) ...
  .*sin(d).*((-8).*gx.*(1+gx).*V.*cos(theta).^2+((-1)+V.^2).^(1/2).* ...
  (2+2.*gp+5.*gp.^2+2.*gx+5.*gx.^2+((-2).*gp+(-5).*gp.^2+gx.*(2+5.* ...
  gx)).*cos(2.*theta))+(-8).*gp.*(1+gp).*V.*sin(theta).^2)+(1/128).* ...
  sin(d).^2.*(128+(-16).*r.^2.*V.*(2+2.*gp+5.*gp.^2+2.*gx+5.*gx.^2+( ...
  (-2).*gp+(-5).*gp.^2+gx.*(2+5.*gx)).*cos(2.*theta))+128.*r.^2.*(( ...
  -1)+V.^2).^(1/2).*(gx.*(1+gx).*cos(theta).^2+gp.*(1+gp).*sin( ...
  theta).^2)+16.*r.^4.*((-1)+3.*V.^2).*(gx.^2.*(1+gx).^2.*cos(theta) ...
  .^4+gp.^2.*(1+gp).^2.*sin(theta).^4)+2.*r.^4.*((-1)+V.^2).*(16.* ...
  gx.^4.*cos(theta).^4+(1+gx).^4.*cos(theta).^4+16.*gp.^4.*sin( ...
  theta).^4+(1+gp).^4.*sin(theta).^4)+16.*gp.*(1+gp).*gx.*(1+gx).* ...
  r.^4.*((-1)+V.^2).*sin(2.*theta).^2+(16.*gp.^2.*gx.^2+(1+gp).^2.*( ...
  1+gx).^2).*r.^4.*((-1)+V.^2).*sin(2.*theta).^2+4.*(gx.^2+2.*gp.* ...
  gx.^2+gp.^2.*(1+2.*gx+2.*gx.^2)).*r.^4.*(1+V.^2).*sin(2.*theta) ...
  .^2+(-16).*r.^4.*V.*((-1)+V.^2).^(1/2).*(gx.*(1+3.*gx+7.*gx.^2+5.* ...
  gx.^3).*cos(theta).^4+(gp+7.*gp.*gx.^2+gx.*(1+gx)+gp.^2.*(1+3.*gx+ ...
  6.*gx.^2)).*cos(theta).^2.*sin(theta).^2+gp.*((1+3.*gp+7.*gp.^2+ ...
  5.*gp.^3).*sin(theta).^4+gx.*sin(2.*theta).^2)))))...
            ,0,inf,0,2*pi,0,3*sigma);
      
    case '3'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            ((1/4).*exp(1).^((-1/4).*r.^2.*(4+gx.^2+gx.^2.*V+gp.^2.*(1+V)+(-1) ...
  .*(gp.^2+(-1).*gx.^2).*(1+V).*cos(2.*theta))).*pi.^(-1).*r.*(4.* ...
  cos(d).^2+r.^2.*((-1)+V.^2).^(1/2).*(gp.^2+gx.^2+((-1).*gp.^2+ ...
  gx.^2).*cos(2.*theta)).*sin(2.*d)+sin(d).^2.*(4+gx.^4.*r.^4.*((-1) ...
  +V.^2).*cos(theta).^4+(-4).*gp.^2.*r.^2.*V.*sin(theta).^2+gp.^4.* ...
  r.^4.*((-1)+V.^2).*sin(theta).^4+2.*gx.^2.*r.^2.*cos(theta).^2.*(( ...
  -2).*V+gp.^2.*r.^2.*((-1)+V.^2).*sin(theta).^2))))...
            ,0,inf,0,2*pi,0,3*sigma);
    
    case '12'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            ((1/4).*exp(1).^((-1/2).*r.*(r.*(2+gx.^2.*(1+V)).*cos(theta).^2+ ...
  sin(theta).*((sqrt(-1)*4).*ra+r.*(2+gp.^2.*(1+V)).*sin(theta)))).* ...
  pi.^(-1).*r.*(4.*cos(d).^2+r.^2.*((-1)+V.^2).^(1/2).*(gp.^2+gx.^2+ ...
  ((-1).*gp.^2+gx.^2).*cos(2.*theta)).*sin(2.*d)+sin(d).^2.*(4+ ...
  gx.^4.*r.^4.*((-1)+V.^2).*cos(theta).^4+(-4).*gp.^2.*r.^2.*V.*sin( ...
  theta).^2+gp.^4.*r.^4.*((-1)+V.^2).*sin(theta).^4+2.*gx.^2.*r.^2.* ...
  cos(theta).^2.*((-2).*V+gp.^2.*r.^2.*((-1)+V.^2).*sin(theta).^2))))...
            ,0,inf,0,2*pi,0,3*sigma);
        
    
    case '13'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^((-1/8).*r.*(r.*(7+(-2).*gx.*((-1)+V)+V+gx.^2.*(3+V)).* ...
  cos(theta).^2+sin(theta).*((sqrt(-1)*8).*(1+gp).*ra+r.*(7+V+(-2).* ...
  gp.*(1+V)+gp.^2.*(3+V)).*sin(theta)))).*pi.^(-1).*r.*(cos(d).^2+( ...
  1/4).*r.^2.*((-1)+V.^2).^(1/2).*cos(d).*sin(d).*(((-1)+gx).^2.* ...
  cos(theta).^2+((-1)+gp).^2.*sin(theta).^2)+(1/128).*sin(d).^2.*( ...
  128+(-32).*r.^2.*V.*(((-1)+gx).^2.*cos(theta).^2+((-1)+gp).^2.* ...
  sin(theta).^2)+2.*r.^4.*((-1)+V.^2).*(((-1)+gx).^4.*cos(theta).^4+ ...
  ((-1)+gp).^4.*sin(theta).^4)+((-1)+gp).^2.*((-1)+gx).^2.*r.^4.*(( ...
  -1)+V.^2).*sin(2.*theta).^2)))...
            ,0,inf,0,2*pi,0,3*sigma);
        
    
    case '23'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^((1/16).*r.*((-1).*r.*(2.*gp.*((-1)+V)+2.*gx.*((-1)+V)+2.* ...
  (7+V)+gp.^2.*(7+V)+gx.^2.*(7+V))+(gp+(-1).*gx).*r.*(2.*((-1)+V)+ ...
  gp.*(7+V)+gx.*(7+V)).*cos(2.*theta)+(sqrt(-1)*16).*((-1)+gp).*ra.* ...
  sin(theta))).*pi.^(-1).*r.*(cos(d).^2+(1/4).*r.^2.*((-1)+V.^2).^( ...
  1/2).*cos(d).*sin(d).*((1+gx).^2.*cos(theta).^2+(1+gp).^2.*sin( ...
  theta).^2)+(1/128).*sin(d).^2.*(128+(-32).*r.^2.*V.*((1+gx).^2.* ...
  cos(theta).^2+(1+gp).^2.*sin(theta).^2)+2.*r.^4.*((-1)+V.^2).*((1+ ...
  gx).^4.*cos(theta).^4+(1+gp).^4.*sin(theta).^4)+(1+gp).^2.*(1+gx) ...
  .^2.*r.^4.*((-1)+V.^2).*sin(2.*theta).^2)))...
            ,0,inf,0,2*pi,0,3*sigma);
        
    case '123'
        F=...
            integral3(@(r,theta,ra)...
            ra.*exp(-ra.^2./sigma).*2./sigma.*...
            (exp(1).^((-1).*r.*(r+(sqrt(-1)*2).*ra.*sin(theta))).*pi.^(-1).*r)...
            ,0,inf,0,2*pi,0,3*sigma);
end

F = real(F);

end