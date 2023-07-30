function fig_compare_all_norm(out, tout, tg, run_mode)
tab = uitab(tg,'title', "All norm error");
axes('Parent',tab);
if run_mode == 2
    ex_all = {out.deltax0, out.deltax, out.deltax1};
    ey_all = {out.deltay0, out.deltay, out.deltay1};
else
    ex_all = {out.deltax, out.deltax_nohvc};
    ey_all = {out.deltay, out.deltay_nohvc};
end
if run_mode == 2
    lgd = {"Ideal Simulation", "Simulation with Actuator and Noise", "Experiment"};
else
    lgd = {"Simulation With HVC", "Simulation Without HVC"};
end
nums = length(ex_all);
for delay_i = 1:nums
    ex = ex_all{delay_i};
    ey = ey_all{delay_i};
    % X channel
    subplot(1, 2, 1);
    hold on;
    plot(tout, vecnorm(ex, 2, 2), 'LineWidth', 3);
    grid on;
    xlabel("Time (second)");
    ylabel("Norm Error in X-channel");
    set(gca, 'FontName','Times New Roman', 'FontSize',17);

    % Y channel
    subplot(1, 2, 2);
    hold on;
    plot(tout, vecnorm(ey, 2, 2), 'LineWidth', 3);
    grid on;
    if delay_i == nums
        hLegend = legend(lgd, 'FontName','Times New Roman', 'FontSize', 16, 'NumColumns', size(ex, 2));
        set(hLegend, 'position', [0.1300    0.025    0.7750    0.01]);
    end
    xlabel("Time (second)");
    ylabel("Norm Error in Y-channel");
    set(gca, 'FontName','Times New Roman', 'FontSize',17);
end
end