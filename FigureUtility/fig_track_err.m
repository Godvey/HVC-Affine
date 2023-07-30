function fig_track_err(out, tout, tg, run_mode)
tab = uitab(tg,'title', "Tracking errors");
axes('Parent',tab);
if run_mode == 2
    ex_all = {out.deltax0, out.deltax, out.deltax1};
    ey_all = {out.deltay0, out.deltay, out.deltay1};
else
    ex_all = {out.deltax};
    ey_all = {out.deltay};
end
nums = length(ex_all);

title_all = {"Ideal Simulation", "Simulation with Actuator and Noise", "Experiment"};

for delay_i = 1:length(ex_all)
    ex = ex_all{delay_i};
    ey = ey_all{delay_i};
    subplot(nums, 2, 2*delay_i-1);
    hold on;
    for i = 1:size(ex, 2)
        lgd{i} = sprintf("Agent %d", i + 3);
        plot(tout, ex(:,i), 'LineWidth', 3);
    end
    grid on;
    if delay_i == nums
        hLegend = legend(lgd, 'FontName','Times New Roman', 'FontSize', 16, 'NumColumns', size(ex, 2));
        set(hLegend, 'position', [0.1300    0.025    0.7750    0.01]);
    end
    xlabel("Time (second)");
    ylabel("Tracking errors in X-channel");
    set(gca, 'FontName','Times New Roman', 'FontSize',12);
    if run_mode == 2
        title(title_all{delay_i}, 'FontName','Times New Roman', 'FontSize', 16);
    end

    % y channel
    subplot(nums, 2, 2*delay_i)
    hold on;
    for i = 1:size(ey, 2)
        lgd{i} = sprintf("Agent %d", i + 3);
        plot(tout, ey(:,i), 'LineWidth', 3);
    end
    grid on;
    %legend(lgd, 'FontName','Times New Roman', 'FontSize', 16, 'NumColumns', 3);
    xlabel("Time (second)");
    ylabel("Tracking errors in Y-channel");
    set(gca, 'FontName','Times New Roman', 'FontSize',12);
    if run_mode == 2
        title(title_all{delay_i}, 'FontName','Times New Roman', 'FontSize', 16);
    end
end
end