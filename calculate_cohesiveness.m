% this file is to calculate cohesiveness
clc;
if length(out) == 1
    out = [out];
end
nums = length(out) + 1;

fprintf("------------------------------------------------------------------------------\n")
fprintf("    Delay τ \t kα \t kβ \t Cohesiveness - X \t Cohesiveness - Y \t\n")
fprintf("------------------------------------------------------------------------------\n")
for i = 1:nums
    if i == nums
        outi = out(1);
        deltax = outi.deltax1;
        deltay = outi.deltay1;
    else
        outi = out(i);
        deltax = outi.deltax;
        deltay = outi.deltay;
    end
    
    sizez = size(deltax,1);
    nodenum = 9;
    followernum = size(deltax,2);
    count = sizez(1) - 1;
    tempx = deltax;
    tempy = deltay;
    avgerrx = sum(deltax, 2)/followernum;
    avgerry = sum(deltay, 2)/followernum;
    tempx = sum(sum(abs(tempx - avgerrx)));
    tempy = sum(sum(abs(tempy - avgerry)));
    tempex = sum(sum(abs(avgerrx)));
    tempey = sum(sum(abs(avgerry)));
    
    couhesiveX = tempx/count;
    couhesiveY = tempy/count;
    
    if i == nums
        fprintf("     %.2f\t%.2f\t----\t      %.3f   \t\t      %.3f \t\n", delay, kalpha, couhesiveX, couhesiveY); 
    else
        fprintf("     %.2f\t%.2f\t%.2f\t      %.3f   \t\t      %.3f \t\n", delay, kalpha, kbeta, couhesiveX, couhesiveY);
    end
end
fprintf("------------------------------------------------------------------------------\n")