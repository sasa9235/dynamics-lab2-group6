%% LCSDATA Splice experimental data to data for 6 full revolution and start at theta = 0
function [theta_exp, w_exp, v_exp, time] = LCSDATA(filename)
% read in data as a matrix
    DATA = readmatrix(filename);
% calculate n of full revolution to remove
    n = floor(DATA(1,2)/360) + 1;
% subtract n full revolution from theta collum
    DATA(:,2) = DATA(:,2) - n*360;
% calculate start bound index for DATA crop for theta to start at ~0
    for j = 1:length(DATA)
        if(DATA(j,2) >= 0) % + DATA(1,2)
            startbound = j;
            break
        end
    end
% calculate end bound index for DATA crop for 6 full revolution
    for i = 1:length(DATA)
        if(DATA(i,2) >= 6*360)
            endbound = i;
            break
        end
    end
% split data matrix into theta, w, v, time and crop data to start/end bound
    theta_exp = DATA(startbound:endbound,2);
    w_exp = DATA(startbound:endbound,4);
    v_exp = DATA(startbound:endbound,5);
    time = DATA(startbound:endbound,1);
end
