function [theta_exp, w_exp, v_exp, time] = LCSDATA(filename)
    DATA = readmatrix(filename);
    n = floor(DATA(1,2)/360);
    DATA(:,2) = DATA(:,2) - n*360;
    for i = 1:length(DATA)
        if(DATA(i,2) >= 6*360) % + DATA(1,2)
            endbound = i;
            break
        end
    end
    theta_exp = DATA(1:endbound,2);
    w_exp = DATA(1:endbound,4);
    v_exp = DATA(1:endbound,5);
    time = DATA(1:endbound,1);
end
