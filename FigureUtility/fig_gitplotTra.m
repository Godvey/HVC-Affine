clear size;
delta=1; %sample
followernum=nodenum-leaderNum;
km=1;
%red [244,126,98] blue [111,128,190]
%backgr of red [252,199,188] backgr of blue [189,192,233]
leadercolor=[244,126,98]/255;
followercolor=[111,128,190]/255;
followerbacgcolor=[189,192,233]/255;
linewith=2;
transP=0.5;


if ~exist("tg", "var") && ~exist("gcf", "var")
    figure;
    set(gcf, 'unit', 'centimeters', 'pos', [7,7,40,10])
else
    tab = uitab(tg,'title', "Trajectory");
    axes('Parent',tab);
    set(0,'defaultfigurecolor','w');
end
if run_mode == 2
    px_a = {out.px0(1:delta:end,:), out.px(1:delta:end,:), out.px1(1:delta:end,:)};
    py_a = {out.py0(1:delta:end,:), out.py(1:delta:end,:), out.py1(1:delta:end,:)};
    ey_all = {out.deltay0(1:delta:end,:), out.deltay(1:delta:end,:), out.deltay1(1:delta:end,:)};
else
    px_a = {out.px(1:delta:end,:)};
    py_a = {out.py(1:delta:end,:)};
    ey_all = {out.deltay(1:delta:end,:)};
end
if run_mode == 2
    title_all = {"Ideal Simulation", "Simulation with Actuator and Noise", "Experiment"};
else
    title_all = {"Simulation With Controller (19)"};
end
nums = length(px_a);

for delay_i = 1:nums
    px_all=px_a{delay_i};
    py_all=py_a{delay_i};
    p_all = zeros(size(px_all,1), size(px_all,2)*2);
    p_all(:,1:2:size(px_all,2)*2) = px_all;
    p_all(:,2:2:size(py_all,2)*2) = py_all;
    error = ey_all{delay_i};

    dataNum=size(p_all); %N*L
    hold off;
    subplot(nums,1,delay_i);
    hold on; box on; axis equal
    xmin = min(min(px_all));
    xmax = max(max(px_all));
    ymin = min(min(py_all));
    ymax = max(max(py_all));
    %set(gca, 'xlim',[xmin-1 xmax+1]);
    %set(gca, 'ylim', [ymin*1.2 ymax*1.2]);


    %plot positions or trajectories.
    % for i = 1:(nodenum-leaderNum)
    %     agent_id = i + leaderNum;
    %     error_all = error(:,i);
    %     px = p_all(1:end,2*agent_id-1);
    %     py = p_all(1:end,2*agent_id);
    %     xdata=[px',flip(px')];
    %     ydata=[py'+km*abs(error_all'),flip(py'-km*abs(error_all'))];
    %     h=fill(xdata,ydata,followerbacgcolor);
    %     set(h,'edgealpha',0,'facealpha',transP);
    % end

    for i=1:nodenum
        px = p_all(1:end,2*i-1);
        py = p_all(1:end,2*i);
        if i <= 3
            fl = plot(px,py,'-','color',leadercolor,'linewidth',linewith);
        else
            ff = plot(px,py,'-','color',followercolor,'linewidth',linewith);
        end
    end

    %t=0
    zhen=1;
    hLine=zeros(nodenum,nodenum);
    for i=1:nodenum
        for j=i+1:nodenum
            if neighborMat(i,j)==1
                pi=p_all(zhen,2*i-1:2*i)';
                pj=p_all(zhen,2*j-1:2*j)';
                hLine(i,j)=line([pi(1),pj(1)], [pi(2),pj(2)], 'linewidth', linewith, 'color', [0,0,0]);
            end
        end
    end
    hMarker=zeros(1,nodenum);
    hText=zeros(1,nodenum);

    for i=1:nodenum
        xi=p_all(zhen,2*i-1);
        yi=p_all(zhen,2*i);
        if i<4
            hMarker(i) = plot(xi, yi, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', leadercolor, 'markersize', 10, 'linewidth', 1);
        end
        if i>=4
            hMarker(i) = plot(xi, yi, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', followercolor, 'markersize', 10, 'linewidth', 1);
        end
        hText(i)=text(xi, yi, num2str(i),'color', [1,1,1], 'FontSize', 8, 'horizontalAlignment', 'center', 'FontWeight', 'bold');
    end


    %t=ends
    zhen=dataNum(1)-2;
    hLine=zeros(nodenum,nodenum);
    for i=1:nodenum
        for j=i+1:nodenum
            if neighborMat(i,j)==1
                pi=p_all(zhen,2*i-1:2*i)';
                pj=p_all(zhen,2*j-1:2*j)';
                hLine(i,j)=line([pi(1),pj(1)], [pi(2),pj(2)], 'linewidth', linewith, 'color', [0,0,0]);
            end
        end
    end
    hMarker=zeros(1,nodenum);
    hText=zeros(1,nodenum);
    for i=1:nodenum
        xi=p_all(zhen,2*i-1);
        yi=p_all(zhen,2*i);
        if i<4
            hMarker(i) = plot(xi, yi, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', leadercolor, 'markersize', 10, 'linewidth', 1);
        end
        if i>=4
            hMarker(i) = plot(xi, yi, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', followercolor, 'markersize', 10, 'linewidth', 1);
        end
        hText(i)=text(xi, yi, num2str(i),'color', [1,1,1], 'FontSize', 8, 'horizontalAlignment', 'center', 'FontWeight', 'bold');
    end
    if delay_i == nums
        lgd = [hMarker(1), hMarker(4), fl, ff];
        if exist("h", "var")
            lgd = [lgd h];
        end
        label = {"Leader", "Follower", "Trajectory of leader", "Trajectory of follower"};
        legend(lgd, label, 'FontName','Times New Roman', 'FontSize', 18, 'Position', [0.17, 0.025, 0.7 ,0.01], ...
            'Orientation','horizon');
    end
    title(title_all{delay_i}, 'FontName','Times New Roman', 'FontSize', 16);
    set(gca, 'FontName','Times New Roman', 'FontSize',18);
end