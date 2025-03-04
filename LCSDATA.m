%{

function [theta_exp, w_exp, v_exp, time] = LCSDATA(filename)
    DATA = readmatrix(filename);
    period_count = -1;
    bounds = [0,0];
    figure(2)
    plot(DATA(1), DATA(2))
    for i = 1:(length(DATA)-1)
        if((DATA(i+1, 3) < DATA(i+2, 3)) && (DATA(i+1, 3) < DATA(i, 3)))
            disp([DATA(i+1, 3), DATA(i+2, 3), DATA(i+1, 3), DATA(i, 3)]);
            period_count = period_count + 1
            if(period_count == 6)
                bounds(2) = i+1
                break
            elseif(period_count == 0)
                bounds(1) = i+1
            end
        end
    end
    DATA(bounds(2):end, :) = [];
    DATA(1:bounds(1), :) = [];

    theta_exp = DATA(:,2) - DATA(1,2);
    w_exp = DATA(:,4);
    v_exp = mean(DATA(:,5));
    time = DATA(:,1) - DATA(1,1);
end

%}

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