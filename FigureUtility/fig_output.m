function fig_output(out, tout, run_mode)
img1 = figure('Name','SineSweep','Units','centimeters', 'Pos',[1 1 25 25]);
if run_mode == 2
    ey_all = {out.deltay0, out.deltay, out.deltay1};
else
    ey_all = {out.deltax};
end
nums = length(ey_all);
title_all = {"Ideal Simulation", "Simulation with Actuator and Noise", "Experiment"};
for delay_i = 1:nums
    ey = ey_all{delay_i};
    % y channel
    subplot(nums, 1, delay_i)
    hold on;
    for i = 1:size(ey, 2)
        lgd{i} = sprintf("Agent %d", i + 3);
        plot(tout, ey(:,i), 'LineWidth', 3);
    end
    grid on;
    if delay_i == 3 && run_mode == 2
        hLegend = legend(lgd, 'FontName','Times New Roman', 'FontSize', 16, 'NumColumns', 6);
        set(hLegend, 'position', [0.1300    0.025    0.7750    0.01]);
    end
    grid on;
    %legend(lgd, 'FontName','Times New Roman', 'FontSize', 16, 'NumColumns', 3);
    xlabel("Time (second)");
    ylabel("Tracking errors in X-channel");
    xlim([0 60])
    ylim([-0.6,0.601]);
    xticklabels(80:10:140);
    yticklabels(-0.6:0.2:0.6);
    set(gca, 'FontName','Times New Roman', 'FontSize',14);
    if run_mode == 2
        title(title_all{delay_i}, 'FontName','Times New Roman', 'FontSize', 18);
    end
end

img2 = figure('Name','SineSweep','Units','centimeters', 'Pos',[31 1 24 12]);
p_all = [];
lgd = {"Ideal Simulation", "Simulation with Actuator and Noise", "Experiment", "Convergence Area"};
hold on;
e_all = ey_all;
for i = 1:nums
    e = e_all{i};
    e_mean = mean(e,2);
    p = plot(tout, e_mean, 'LineWidth', 4);
    %v = 3*var(e, 0, 2);
    %xdata=[e',flip(e')];
    %ydata=[e'+abs(v'),flip(e'-abs(v'))];
    %h=fill(xdata,ydata,p.Color);
    %set(h,'edgealpha',0,'facealpha',0.5);
    p_all = [p_all p];
end
h=fill([20 60 60 20],[-0.08 -0.08 0.08 0.08],[189,192,233]/255);
set(h,'edgealpha',0,'facealpha',0.5);
xlim([0 60])
ylim([-0.6,0.601]);
xticklabels(80:10:140);
yticklabels(-0.6:0.2:0.6);
xlabel("Time (second)");
ylabel("Mean Tracking error in X-channel");
if run_mode == 2
    legend([p_all h], lgd, 'FontName','Times New Roman', 'FontSize', 16, 'NumColumns', 2);
end
set(gca, 'FontName','Times New Roman', 'FontSize',18);
grid on;
exportgraphics(img1, "./1.pdf", "ContentType","vector");
exportgraphics(img2, "./2.pdf", "ContentType","vector");
end