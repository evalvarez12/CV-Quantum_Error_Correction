
V = 1;
sigma = 10;
epsilon = 0;

sigmaT = 0.0;
meanT = 0.6;
T1 = normrnd(meanT, sigmaT);
T2 = normrnd(meanT, sigmaT);
T3 = normrnd(meanT, sigmaT);
% 
% T1 = 1;
% T2 = 1;
% T3 = 1;


disp(['T1 - ', num2str(T1)]);
disp(['T2 - ', num2str(T2)]);
disp(['T3 - ', num2str(T3)]);

g1 = 0;
g2 = 1;
g3 = -1;

disp([ g1, fid_tmsv_gen_loss_gs(V, 0, sigma, T1, T2, T3, epsilon)/2]);
disp([ g2, fid_tmsv_gen_loss_gs(V, 1, sigma, T1, T2, T3, epsilon)/2]);
disp([ g3, fid_tmsv_gen_loss_gs(V, -1, sigma, T1, T2, T3, epsilon)/2]);

disp([ g1, fid_tmsv_gen_loss_eq(V, 0, sigma, T1, T2, T3, epsilon)/2]);
disp([ g2, fid_tmsv_gen_loss_eq(V, 1, sigma, T1, T2, T3, epsilon)/2]);
disp([ g3, fid_tmsv_gen_loss_eq(V, -1, sigma, T1, T2, T3, epsilon)/2]);




T_mean = (T1 + T2 + T3)/3;
%%%%% Direct
F_dir1 =  2 / (2*sigma*(1-sqrt(T1))^2 + 2 + eps);
F_dir2 =  2 / (2*sigma*(1-sqrt(T2))^2 + 2 + eps);
F_dir3 =  2 / (2*sigma*(1-sqrt(T3))^2 + 2 + eps);

F_dir = (F_dir1 + F_dir2 + F_dir3)/3;
F_dir




% T = 0.8;
% F_dir =  2 / (2*sigma*(1-sqrt(T))^2 + 2 + eps);
% F_dir*2
% 
% fid_tmsv_dir(T, 0, sigma)

