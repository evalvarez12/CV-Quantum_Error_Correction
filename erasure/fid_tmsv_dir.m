function [F] = fid_tmsv_dir(T1r, epsilon, sigma)


warning('off')
F=...
integralN(@(r,theta,ra,ri)...
exp(-(ra.^2 + ri.^2)./sigma).*1/(pi*sigma).*...
(exp(1).^((-1/4).*r.*((2+epsilon).*r+(sqrt(-1)*4).*2.^(1/2).*ri.*(( ...
  -1)+T1r.^(1/2)).*cos(theta)+(sqrt(-1)*(-4)).*2.^(1/2).*ra.*((-1)+ ...
  T1r.^(1/2)).*sin(theta))).*pi.^(-1).*r)...
,0,inf,0,2*pi,-3*sigma,3*sigma,-3*sigma,3*sigma);


F = real(F);

end