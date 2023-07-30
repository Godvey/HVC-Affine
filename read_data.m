p = load("./data/Position-smallTau-after80s.txt");
v = load("./data/Velocity-smallTau-after80s.txt");
tout = p(:,end);
p(:,end) = [];
v(:,end) = [];
tmp = p(:,1:2:end);
p(:,1:2:end) = p(:,2:2:end);
p(:,2:2:end) = tmp;
tmp = v(:,1:2:end);
v(:,1:2:end) = v(:,2:2:end);
v(:,2:2:end) = tmp;
tout = tout - tout(1);
clear tmp;

function dp = calc_dp(p)
dp = p;
dp(1) = [];
dp = [dp; 0];
dp = p - dp;
dp(end) = 0;
end
