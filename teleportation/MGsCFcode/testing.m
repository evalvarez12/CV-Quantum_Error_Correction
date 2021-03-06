clc;clear

OptOption = optimoptions(@fmincon, 'FunctionTolerance', 1e-30,'StepTolerance', 1e-20, 'Display','off');

% 'algorithm','sqp'
e = 7e-3;


tnum = 15;
% tdB = linspace(1, 15, tnum);
ts = linspace(0, 1, tnum);

F_ps = zeros(1, tnum);
F_pa = F_ps;
F_pc = F_ps;
F_as = F_ps;
F_sa = F_ps;
Fepr = F_ps;

opt_ps = F_ps;
opt_pa = F_ps;
opt_pc = F_ps;
opt_sa = F_ps;
opt_as = F_ps;


gmax = 10;
gmin = 0.1;
gini = 0.1;

% gmax = 1;
% gmin = 1;
% gini = 1;

Tmax = 0.999;
Tmin = 0.001;
Tini = 0.99;


rmax = 1;
rmin = 0;
rini = .5;

sig = 1;

parfor i = 1:tnum
%     t = 10^(-tdB(i)/10);
    t = ts(i);
    disp([i,t]);
    
    fun_ep = @(par) -coh_loss(par(1), par(2), t, e, 'epr', 1, sig);
    fun_ps = @(par) -coh_loss(par(1), par(2), t, e, 'ps', 1,  sig);
%     fun_pa = @(par) -coh_loss(par(1), par(2), t, e, 'pa', par(3),  sig);
%     fun_pc = @(par) -coh_loss(par(1), par(2), t, e, 'pc', par(3),  sig);
    fun_as = @(par) -coh_loss(par(1), par(2), t, e, 'as', 1,  sig);
%     fun_sa = @(par) -coh_loss(par(1), par(2), t, e, 'sa', par(3),  sig);
%     
    [~, Fepr(i)] = fmincon(fun_ep, [Tini, rini], [],[],[],[], [Tmin, rmin], [Tmax, rmax], [], OptOption);
    [~, F_ps(i)] = fmincon(fun_ps, [Tini, rini], [],[],[],[], [Tmin, rmin], [Tmax, rmax], [], OptOption);
%     [~, F_pa(i)] = fmincon(fun_pa, [Tini, rini, gini], [],[],[],[], [Tmin, rmin, gmin], [Tmax, rmax, gmax], [], OptOption);
%     [~, F_pc(i)] = fmincon(fun_pc, [Tini, rini, gini], [],[],[],[], [Tmin, rmin, gmin], [Tmax, rmax, gmax], [], OptOption);
    [~, F_as(i)] = fmincon(fun_as, [Tini, rini], [],[],[],[], [Tmin, rmin], [Tmax, rmax], [], OptOption);
%     [~, F_sa(i)] = fmincon(fun_sa, [Tini, rini, gini], [],[],[],[], [Tmin, rmin, gmin], [Tmax, rmax, gmax], [], OptOption);


end


Fepr = -Fepr;
F_ps = -F_ps;
% F_pa = -F_pa;
% F_pc = -F_pc;
F_as = -F_as; 
% F_sa = -F_sa;
% 
Fepr
F_ps
% F_ps
% F_pc
F_as
% F_sa
% 
results = [Fepr(:), F_ps(:), F_as(:)];
save('results.mat', 'results');

