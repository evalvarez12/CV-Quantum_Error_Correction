clear all;
close all;


data_py = load('fixed_py');
data_m_sig2 = load('results_sig2');
data_m_sig5 = load('results_sig5');
data_m_sig10 = load('results_sig10');
data_m_sig20 = load('results_sig20');

data_py = data_py.data;
data_m_sig2 = data_m_sig2.results;
data_m_sig5 = data_m_sig5.results;
data_m_sig10 = data_m_sig10.results;
data_m_sig20 = data_m_sig20.results;

t = cell2mat(data_py(1));

tmsv_py = cell2mat(data_py(2));
tmsv_py_sig2 = tmsv_py(1,:);
tmsv_py_sig5 = tmsv_py(2,:);
tmsv_py_sig10 = tmsv_py(3,:);
tmsv_py_sig20 = tmsv_py(4,:);

qs_py = cell2mat(data_py(3));
qs_py_sig2 = qs_py(1,:);
qs_py_sig5 = qs_py(2,:);
qs_py_sig10 = qs_py(3,:);
qs_py_sig20 = qs_py(4,:);

tmsv_m_sig2 = data_m_sig2(:,1);
tmsv_m_sig5 = data_m_sig5(:,1);
tmsv_m_sig10 = data_m_sig10(:,1);
tmsv_m_sig20 = data_m_sig20(:,1);

ps_m_sig2 = data_m_sig2(:,2);
ps_m_sig5 = data_m_sig5(:,2);
ps_m_sig10 = data_m_sig10(:,2);
ps_m_sig20 = data_m_sig20(:,2);

pa_m_sig2 = data_m_sig2(:,3);
pa_m_sig5 = data_m_sig5(:,3);
pa_m_sig10 = data_m_sig10(:,3);
pa_m_sig20 = data_m_sig20(:,3);

pc_m_sig2 = data_m_sig2(:,4);
pc_m_sig5 = data_m_sig5(:,4);
pc_m_sig10 = data_m_sig10(:,4);
pc_m_sig20 = data_m_sig20(:,4);

as_m_sig2 = data_m_sig2(:,5);
as_m_sig5 = data_m_sig5(:,5);
as_m_sig10 = data_m_sig10(:,5);
as_m_sig20 = data_m_sig20(:,5);

sa_m_sig2 = data_m_sig2(:,6);
sa_m_sig5 = data_m_sig5(:,6);
sa_m_sig10 = data_m_sig10(:,6);
sa_m_sig20 = data_m_sig20(:,6);




figure;
hold all;

sa_m_sig5(1) = 0.2875;
ps_m_sig5(1) = 0.27456;
ps_m_sig5(2) = 0.28067;

plot(t, tmsv_py_sig5,'k-', 'LineWidth', 3, 'DisplayName', 'TMSV');
plot(t, qs_py_sig5, 'o-', 'DisplayName', 'QS');
plot(t, ps_m_sig5, 'o-', 'DisplayName', 'PS');
plot(t, pa_m_sig5, 'o-', 'DisplayName', 'PA');
plot(t, pc_m_sig5, 'o-', 'DisplayName', 'PC');
plot(t, as_m_sig5, 'o-', 'DisplayName', 'PA-PS');
plot(t, sa_m_sig5, 'o-', 'DisplayName', 'PS-PA');

legend('Location', 'southeast');
ylabel('$\bar{\mathcal{F}}$', 'Interpreter', 'latex');
xlabel('$T$', 'Interpreter', 'latex');

txt1 = ('\sigma = 5');
text(0.015, .85, txt1);

savefigures('fixed1')


figure;
hold all;
plot(t, tmsv_py_sig2, '-', 'LineWidth', 1.5, 'DisplayName', 'TMSV\sigma = 2')
plot(t, tmsv_py_sig5, '-', 'LineWidth', 1.5, 'DisplayName', 'TMSV \sigma = 5')
plot(t, tmsv_py_sig10, '-', 'LineWidth', 1.5, 'DisplayName', 'TMSV \sigma = 10')
plot(t, tmsv_py_sig20, '-', 'LineWidth', 1.5,'DisplayName', 'TMSV \sigma = 20')
% plot(t, tmsv_m_sig2, 'ro')
% plot(t, tmsv_m_sig5, 'ro')
% plot(t, tmsv_m_sig10, 'ro')
% plot(t, tmsv_m_sig20, 'ro')

% plot(t, qs_py_sig2)
% plot(t, qs_py_sig5)
% plot(t, qs_py_sig10)
% plot(t, qs_py_sig20)

% plot(t, ps_m_sig2)
% plot(t, ps_m_sig5)
% plot(t, ps_m_sig10)
% plot(t, ps_m_sig20)
% 
% plot(t, pa_m_sig2)
% plot(t, pa_m_sig5)
% plot(t, pa_m_sig10)
% plot(t, pa_m_sig20)
% 
% plot(t, pc_m_sig2)
% plot(t, pc_m_sig5)
% plot(t, pc_m_sig10)
% plot(t, pc_m_sig20)
% 
plot(t, as_m_sig2, 'o-', 'DisplayName', 'PA-PS \sigma = 2')
plot(t, as_m_sig5, 'o-', 'DisplayName', 'PA-PS \sigma = 5')
plot(t, as_m_sig10, 'o-', 'DisplayName', 'PA-PS \sigma = 10')
plot(t, as_m_sig20, 'o-', 'DisplayName', 'PA-PS \sigma = 20')
% 
% plot(t, sa_m_sig2)
% plot(t, sa_m_sig5)
% plot(t, sa_m_sig10)
% plot(t, sa_m_sig20)


legend('Location', 'southeast');
ylabel('$\bar{\mathcal{F}}$', 'Interpreter', 'latex');
xlabel('$T$', 'Interpreter', 'latex');
savefigures('fixed2')


% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% Histograms
% t_ext = 10^(-1/10) * exp(-0.7);
% 
% 
% data_up = load('../../../Laser_propagation/data/TELE_final2_UP_I_r=1_z=0_1024_10000');
% data_up = data_up.res .* t_ext;
% 
% data_down = load('../../../Laser_propagation/data/TELE_final2_DOWN_I_r=1_z=0_1024_10000');
% data_down = data_down.res .* t_ext;
% 
% figure
% hold on
% histogram(data_up, 'Normalization', 'pdf', 'EdgeColor', 'red', 'FaceAlpha', 0.6, 'DisplayStyle', 'stairs');
% histogram(data_down, 'Normalization', 'pdf', 'EdgeColor', 'blue', 'FaceAlpha', 0.6, 'DisplayStyle', 'stairs');
% 
% % xline(mean(data_up), 'k--', 'LineWidth', 1.25);
% xlim([min(data_up) max(data_down)]);
% 
% ylabel('Probability Distribution', 'Interpreter', 'latex');
% xlabel('$T$', 'Interpreter', 'latex');
% 
% 
% txt1 = ('Downlink');
% txt2 = ('Uplink');
% txt3 = ('$L_0=$ Coulman-Vernin');
% txt4 = ('$l_0= \delta L_0$');
% text(0.08 , 930, txt1);
% text(0.04 , 550, txt2);
% text(0.04 , 860, txt3);
% text(0.041 , 805, txt4);
% 
% pbaspect([1 0.618 1])
% 
% axes('Position',[.49 .55 .33 .28])
% box on
% histogram(data_down, 'Normalization', 'pdf', 'FaceColor', 'blue', 'FaceAlpha', 0.6, 'NumBins', 35);
% 
% 
% axes('Position',[.17 .21 .33 .33])
% box on
% histogram(data_up, 'Normalization', 'pdf', 'FaceColor', 'red', 'FaceAlpha', 0.6);
% 
% savefigures('hist1');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% Channel properties
% data = load('channel.mat');
% data = data.data;
% 
% zs = data(1,:);
% d_t = data(2,:);
% d_noise = data(3,:);
% u_t = data(4,:);
% u_noise = data(5,:);
% 
% figure
% % title('Satellite communications channels properties')
% hold on
% 
% yyaxis left
% plot(zs, d_t, 'o-', 'DisplayName', 'Teleportation');
% plot(zs, u_t, 'o--', 'DisplayName', 'Direct');
% ylabel('$T_f$ [dB]', 'Interpreter', 'latex')
% 
% 
% yyaxis right
% plot(zs, d_noise, 'o-', 'DisplayName', 'Teleportation');
% plot(zs, u_noise, 'o--', 'DisplayName', 'Direct');
% ylabel('$\epsilon_f$', 'Interpreter', 'latex')
% set ( gca, 'ydir', 'reverse' )
% ylim([0 0.13]);
% 
% txt1 = ('$7.1 \times 10^{-3}$');
% text(48 , 0.015, txt1);
% 
% txt2 = ('$7.0 \times 10^{-3}$');
% text(2 , 0.015, txt2);
% 
% legend('Position', [.16 .39 .2 .2]);
% xlabel('$\zeta$ [deg]', 'Interpreter', 'latex')
% % grid on;
%  set(gca,'Box','on');
% 
% savefigures('channel');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% Fixed loss
% data = load('fixed.mat');
% data = data.data;
% 
% zs = data(1,:);
% tele1 = data(2,:);
% tele2 = data(3,:);
% tele3 = data(4,:);
% tele4 = data(5,:);
% dir1 = data(6,:);
% dir2 = data(7,:);
% dir3 = data(8,:);
% dir4 = data(9,:);
% 
% classical = ones(1, length(tele1)) * .5;
% 
% fig = figure;
% % title('Fixed channel fidelities')
% 
% fill([0,15,15,0], [0,0,0.5,0.5],  [1,.75,.75] ,'Edgecolor', 'none', 'handlevisibility', 'off')
% 
% 
% 
% hold on
% 
% plot(zs(1:1:end), tele1(1:1:end), '-', 'DisplayName', 'Teleportation $\sigma = 2$', 'color', [0, 0, 1]);
% plot(zs(1:1:end), tele2(1:1:end), '-', 'DisplayName', 'Teleportation $\sigma = 4$', 'color', 	[1, 0, 0]);
% plot(zs(1:1:end), tele3(1:1:end), '-', 'DisplayName', 'Teleportation $\sigma = 10$', 'color', [0, 0.5, 0]);
% plot(zs(1:1:end), tele4(1:1:end), '-', 'DisplayName', 'Teleportation $\sigma = 25$', 'color', [0.4940, 0.1840, 0.5560] );
% plot(zs(1:1:end), dir1(1:1:end), '--', 'DisplayName', 'Direct $\sigma = 2$', 'color', [0, 0, 1]);
% plot(zs(1:1:end), dir2(1:1:end), '--', 'DisplayName', 'Direct $\sigma = 4$', 'color', 	[1, 0, 0]);
% plot(zs(1:1:end), dir3(1:1:end), '--', 'DisplayName', 'Direct $\sigma = 10$', 'color', [0, 0.5, 0]);
% plot(zs(1:1:end), dir4(1:1:end), '--', 'DisplayName', 'Direct $\sigma = 25$', 'color', [0.4940, 0.1840, 0.5560]);
% 
% plot(zs, classical, 'r--', 'HandleVisibility','off');
% 
% ylim([0.46 1]);
% xlim([0 13]);
% 
% ylabel('$\bar{\mathcal{F}}$', 'Interpreter', 'latex')
% xlabel('Fixed loss [dB]', 'Interpreter', 'latex')
% legend;
% 
% txt1 = ('classical limit');
% text(0.1 , 0.52, txt1, 'Color', 'r');
% 
% % grid on;
%  set(gca,'Box','on');
% 
% savefigures('fixed');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% Fidelities
% data = load('fidelities.mat');
% data = data.data;
% 
% zs = data(1,:);
% tele1 = data(2,:);
% tele2 = data(3,:);
% tele3 = data(4,:);
% tele4 = data(5,:);
% dir1 = data(6,:);
% dir2 = data(7,:);
% dir3 = data(8,:);
% 
% classical = ones(1, length(tele1)) * .5;
% 
% fig = figure;
% % title('Satellite-to-ground fidelities')
% 
% 
% fill([0,60,60,0], [0,0,0.5,0.5],  [1,.75,.75] ,'Edgecolor', 'none', 'handlevisibility', 'off')
% 
% 
% hold on
% 
% plot(zs, tele1, 'o-', 'DisplayName', 'Teleportation $\sigma = 2$', 'color', [0, 0, 1]);
% plot(zs, tele2, 'o-', 'DisplayName', 'Teleportation $\sigma = 4$', 'color', 	[1, 0, 0]);
% plot(zs, tele3, 'o-', 'DisplayName', 'Teleportation $\sigma = 10$', 'color', [0, 0.5, 0]);
% plot(zs, tele4, 'o-', 'DisplayName', 'Teleportation $\sigma = 25$', 'color', [0.4940, 0.1840, 0.5560] );
% plot(zs, dir1, 'v--', 'DisplayName', 'Direct $\sigma = 2$', 'color', [0, 0, 1]);
% plot(zs, dir2, 'v--', 'DisplayName', 'Direct $\sigma = 4$', 'color', 	[1, 0, 0]);
% % plot(zs, dir3, 'v--', 'DisplayName', 'Direct $\sigma = 10$', 'color', 	[0, 0.5, 0]);
% 
% plot(zs, classical, 'r--', 'HandleVisibility','off');
% 
% ylim([0.35 0.72]);
% 
% ylabel('$\bar{\mathcal{F}}$', 'Interpreter', 'latex')
% xlabel('$\zeta$ [deg]', 'Interpreter', 'latex')
% legend('Location', 'northeast');
% 
% txt1 = ('classical limit');
% text(0.8 , 0.48, txt1, 'Color', 'r');
% 
% % grid on;
%  set(gca,'Box','on');
% legend('NumColumns', 2);
%  
% savefigures('fidelities');
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% Fidelities direct transmission optmized
% data_opt = load('fidelities_opt_direct.mat');
% data_opt = data_opt.data;
% 
% zs = data_opt(1,:);
% tele1 = data_opt(2,:);
% tele2 = data_opt(3,:);
% tele3 = data_opt(4,:);
% tele4 = data_opt(5,:);
% dir1 = data_opt(6,:);
% dir2 = data_opt(7,:);
% dir3 = data_opt(8,:);
% dir4 = data_opt(9,:);
% 
% classical = ones(1, length(tele1)) * .5;
% 
% fig = figure;
% % title('Satellite-to-ground fidelities')
% 
% 
% fill([0,60,60,0], [0,0,0.5,0.5],  [1,.75,.75] ,'Edgecolor', 'none', 'handlevisibility', 'off')
% 
% 
% hold on
% 
% plot(zs, tele1, 'o-', 'DisplayName', 'Teleportation $\sigma = 2$', 'color', [0, 0, 1]);
% plot(zs, tele2, 'o-', 'DisplayName', 'Teleportation $\sigma = 4$', 'color', 	[1, 0, 0]);
% plot(zs, tele3, 'o-', 'DisplayName', 'Teleportation $\sigma = 10$', 'color', [0, 0.5, 0]);
% plot(zs, tele4, 'o-', 'DisplayName', 'Teleportation $\sigma = 25$', 'color', [0.4940, 0.1840, 0.5560] );
% plot(zs, dir1, 'v--', 'DisplayName', 'Direct $\sigma = 2$', 'color', [0, 0, 1]);
% plot(zs, dir2, 'v--', 'DisplayName', 'Direct $\sigma = 4$', 'color', 	[1, 0, 0]);
% plot(zs, dir3, 'v--', 'DisplayName', 'Direct $\sigma = 10$', 'color', 	[0, 0.5, 0]);
% plot(zs, dir4, 'v--', 'DisplayName', 'Direct $\sigma = 25$', 'color', 	[0.4940, 0.1840, 0.5560]);
% 
% plot(zs, classical, 'r--', 'HandleVisibility','off');
% 
% ylim([0.07 0.95]);
% 
% ylabel('$\bar{\mathcal{F}}$', 'Interpreter', 'latex')
% xlabel('$\zeta$ [deg]', 'Interpreter', 'latex')
% legend('Location', 'southwest');
% 
% txt1 = ('classical limit');
% % text(0.8 , 0.48, txt1, 'Color', 'r');
% 
% % grid on;
%  set(gca,'Box','on');
% legend('NumColumns', 2);
%  
% savefigures('fidelities_opt_direct');
