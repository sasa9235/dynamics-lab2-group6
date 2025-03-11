function [theta_exp, w_exp, v_exp, time] = LCSDATA(filename)
%152.5
    DATA = readmatrix(filename);
    n = floor(DATA(1,2)/360) + 1;
    DATA(:,2) = DATA(:,2) - n*360;
    for j = 1:length(DATA)
        if(DATA(j,2) >= 0) % + DATA(1,2)
            startbound = j;
            break
        end
    end
    for i = 1:length(DATA)
        if(DATA(i,2) >= 6*360) % + DATA(1,2)
            endbound = i;
            break
        end
    end
    theta_exp = DATA(startbound:endbound,2);
    w_exp = DATA(startbound:endbound,4);
    v_exp = DATA(startbound:endbound,5);
    time = DATA(startbound:endbound,1);
end
