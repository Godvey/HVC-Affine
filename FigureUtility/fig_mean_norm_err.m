function fig_mean_norm_err(out, tout, tg, channel, run_mode)
channels = {"X", "Y"};
tab = uitab(tg,'title', "Mean Tracking Error in X");
axes('Parent',tab);
hold on;
if run_mode == 2
    ex_all = {out.deltax0, out.deltax, out.deltax1};
    ey_all = {out.deltay0, out.deltay, out.deltay1};
else
    ex_all = {out.deltax, out.deltax_nohvc};
    ey_all = {out.deltay, out.deltay_nohvc};
end
if channel == 1
    e_all = ex_all;
else
    e_all = ey_all;
end
if run_mode == 2
    lgd = {"Ideal Simulation", "Simulation with Actuator and Noise", "Experiment"};
else
    lgd = {"Simulation With HVC", "Simulation Without HVC"};
end
hold on;
for i = 1:length(ex_all)
    e = e_all{i};
    e_mean = mean(e,2);
    plot(tout, e_mean, 'LineWidth', 4);
end
xlabel("Time (second)");
ylabel(sprintf("Mean Tracking error in %s-channel", channels{channel}));
legend(lgd, 'FontName','Times New Roman', 'FontSize', 20);
set(gca, 'FontName','Times New Roman', 'FontSize',22);
grid on;
end