p = load(filename);
v = load("data/Case2-smallTau-V.txt");
tout = p(:,end);
p(:,end) = [];
p = p(tout>time_cut,:);
tmp = p(:,1:2:end);
p(:,1:2:end) = p(:,2:2:end);
p(:,2:2:end) = tmp;
v(:,end) = [];
v = v(tout>time_cut,:);
tmp = v(:,1:2:end);
v(:,1:2:end) = v(:,2:2:end);
v(:,2:2:end) = tmp;
tout = tout(tout>time_cut);
tout = tout - tout(1);
clear tmp;
%plot(tout, v(:,12))
%
for i = 1:size(p,2)
    % pi = p(:,i);
    % vi = v(:,i);
    % dp = calc_dp(pi);
    % if mod(i,2) == 0
    %     out_pts = find(abs(dp) > 0.015);
    % else
    %     out_pts = find(abs(dp) > 0.08);
    % end
    % for out_pt = out_pts'
    %     pi(out_pt+1:end) = pi(out_pt+1:end) + dp(out_pt);
    %     vi(out_pt+1) = 0;
    % end
    % p(:,i) = pi;
    % v(:,i) = vi;
    % % if i == 2
    % %     plot(tout, dp);
    % %     hold on;
    % %     plot(tout, calc_dp(pi));
    % % end
end
p = p(tout >= start_time, :);
v = v(tout >= start_time, :);
tout = tout(tout >= start_time) - start_time;

function dp = calc_dp(p)
dp = p;
dp(1) = [];
dp = [dp; 0];
dp = p - dp;
dp(end) = 0;
end
