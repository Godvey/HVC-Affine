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
