close all;

%% figure mode and run mode
run_mode = 2; % 1 for theoretical simulation, 2 for experiment simulation
fig_from_data = false; % only support experiment simulation
data_dir = "./SimulationResults/data.mat";

%% Delay & contoller settings
delay = 0.01;
cmd_sample = 0.1;
kalpha = 0.5;
kbeta = 0.5;
Tv = 0.16;
Kv = 0.987 / Tv;

%% Kinematics settings
kptheta = 100;
R = 3.2e-3;
L = 10.5e-3;

%% Noise settings
% magnitude
noise_v = normrnd(0.001, 0.025,[1 6]);
noise_p = normrnd(0.001, 0.025,[1 6]);
% sample time
noise_vT = 0.1;
noise_pT = 3;
% seeds
rng('shuffle');
seed_v = zeros(1,6);
seed_p = zeros(1,6);
for i = 1:length(seed_v)
    seed_v(i) = floor(rand()*10000000);
    seed_p(i) = floor(rand()*10000000);
end
% note: if you need to design leaders acceration, please go to Initial_Parameters.m
% furthermore you can design it with simulink file in "Leaders Acceration Design" Block.

%% Read Data settings
if run_mode == 2
    read_data;
    vl = 1;
    P0 = [p(1,1:2:end)' p(2,2:2:end)'];
end

%% Run Simulation
if exist("tout", "var")
    simtime = 60;
else
    simtime = 80;
end
simstep = 0.01;

% Run simulation
if fig_from_data
    load(data_dir)
else
    option = simset('fixedstep',simstep);
    if run_mode == 2
        out = sim('affine_single_integrator_ex.slx', [0, simtime], option);
    else
        out = sim('affine_single_integrator.slx', [0, simtime], option);
    end
    tout = out.tout;
end

%% figure
addpath("FigureUtility/")
set(0,'defaultfigurecolor','w');
figure('Name','SineSweep','Units','centimeters', 'Pos',[1 1 40 25], 'Name', "Result");
tg = uitabgroup;
fig_gitplotTra;
fig_track_err(out, tout, tg, run_mode);
fig_compare_all_norm(out, tout, tg, run_mode);
if run_mode == 2
    % fig_output(out, tout, run_mode)
    save("./SimulationResults/data.mat")
else
    calculate_cohesiveness;
end

%% end
clear;