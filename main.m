clc
clear
close all

%% General Parameter
r = 7.5;
d = 15.5;
l = 26;
delta_measurment = 0.05;


%% Process datas
Volt = ["5.5V", "6.5V", "7.5V", "8.5V", "9.5V", "10.5V"];

for i = 5:10
    [theta_exp.("V" + num2str(i)), w_exp.("V" + num2str(i)), v_exp.("V" + num2str(i)), time_exp.("V" + num2str(i))] = LCSDATA("Locomotive_Data_2020\Test1_" + num2str(i) + "pt5V");
end


%% Calculate Model

for i = 5:10
    v_mod.("V" + num2str(i)) = LCSMODEL(r, d, l, theta_exp.("V" + num2str(i)), mean(w_exp.("V" + num2str(i)))*ones(size(w_exp.("V" + num2str(i)))));
end


%% Calculate Residual

% Signed vs Time
for i = 5:10
    res_s.("V" + num2str(i)) = -v_exp.("V" + num2str(i)) * 10^-1 + LCSMODEL(r, d, l, theta_exp.("V" + num2str(i)), w_exp.("V" + num2str(i)));
end

% Signed vs Theta
for i = 5:10
    res_s_t.("V" + num2str(i)) = v_exp.("V" + num2str(i)) * 10^-1 - v_mod.("V" + num2str(i));
end


%% Plot

% V_model vs Theta
figure("Name", "Model vs Experimental Data")
for i=5:10
    subplot(2,3,i-4)
    title("Model vs Experimental Data " + Volt(i-4))
    hold on
    plot(theta_exp.("V" + num2str(i)), v_mod.("V" + num2str(i)))
    xlim([0,360*6.5])
    ylim([-200, 250])
    xlabel('Wheel Angular Position [degree]')
    ylabel('Coller Velocity (v_B_,_y) [m/s]')
    hold off
end

% V_model & V_actual vs Theta
figure("Name", "Model vs Experimental Data")
for i=5:10
    subplot(2,3,i-4)
    title("Model vs Experimental Data " + Volt(i-4))
    hold on
    plot(theta_exp.("V" + num2str(i)), v_mod.("V" + num2str(i)))
    plot(theta_exp.("V" + num2str(i)), v_exp.("V" + num2str(i)) * 10^-1)
    xlim([0,360*6.5])
    ylim([-200, 250])
    xlabel('Wheel Angular Position [degree]')
    ylabel('Coller Velocity (v_B_,_y) [m/s]')
    legend("Model", "Experimental")
    hold off
end


sign_mean = zeros(1,6);
sign_std = zeros(1,6);
% Sign Residual vs Time
figure("Name", "Signed Residuals vs Time")
for i=5:10
    subplot(2,3,i-4)
    title("Signed Residuals " + Volt(i-4))
    hold on
    plot(time_exp.("V" + num2str(i)), res_s.("V" + num2str(i)))
    plot([0,time_exp.("V" + num2str(i))(end)],[mean(res_s.("V" + num2str(i))),mean(res_s.("V" + num2str(i)))],'LineStyle','--')
    ylim([-30, 30])
    xlabel('Time (t) [sec]')
    ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
    legend("Residual", "mean")
    sign_mean(i-4) = mean(res_s.("V" + num2str(i)));
    sign_std(i-4) = std(res_s.("V" + num2str(i)));
    hold off
end

% Table
sz = [6, 3];
varTypes = ["string","double","double"];
varNames = ["Voltage","mean","standard deviation"];mean_std_table = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
mean_std_table(1,:) = {"5.5V", sign_mean(1), sign_std(1)};
mean_std_table(2,:) = {"6.5V", sign_mean(2), sign_std(2)};
mean_std_table(3,:) = {"7.5V", sign_mean(3), sign_std(3)};
mean_std_table(4,:) = {"8.5V", sign_mean(4), sign_std(4)};
mean_std_table(5,:) = {"9.5V", sign_mean(5), sign_std(5)};
mean_std_table(6,:) = {"10.5V", sign_mean(6), sign_std(6)};



%abs_mean = zeros(1,6);
%abs_std = zeros(1,6);
% Absolute Residual vs Time
figure("Name", "Absolute Residuals vs Time")
for i=5:10
    subplot(2,3,i-4)
    title("Absolute Residuals " + Volt(i-4))
    hold on
    plot(time_exp.("V" + num2str(i)), abs(res_s.("V" + num2str(i))))
    plot([0,time_exp.("V" + num2str(i))(end)],[mean(abs(res_s.("V" + num2str(i)))),mean(abs(res_s.("V" + num2str(i))))],'LineStyle','--')
    ylim([-5, 30])
    xlabel('Time (t) [sec]')
    ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
    legend("Residual", "mean")
    %sign_mean(i-4) = mean(abs(res_s.("V" + num2str(i))));
    %sign_std(i-4) = std(abs(res_s.("V" + num2str(i))));
    hold off
end

% Both Residual vs Time
figure("Name", "Sign and Absolute Residuals vs Time (7.5V)")
title("Sign and Absolute Residuals vs Time (7.5V)")
hold on
plot(time_exp.("V" + num2str(7)), res_s.("V" + num2str(7)))
plot(time_exp.("V" + num2str(7)), abs(res_s.("V" + num2str(7))))
plot([0,time_exp.("V" + num2str(7))(end)],[0,0],'LineStyle','--')
ylim([-20, 20])
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
hold off

% Signed Residual vs Time Comparison
figure("Name", "Signed Residuals vs Time Comparison")
title("Signed Residuals vs Time Comparison")
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
hold on
for i=5:10
    plot(theta_exp.("V" + num2str(i)), res_s.("V" + num2str(i)))
end
ylim([-50, 45])
plot([0,theta_exp.("V" + num2str(5))(end)],[0,0],'LineStyle','--')
legend("5.5V", "6.5V", "7.5V", "8.5V", "9.5V", "10.5V", "zero")

% Signed Residual vs Theta
figure("Name", "Signed Residuals vs Theta")
title("Signed Residuals vs Wheel Angular Position")
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
hold on
for i=5:10
    plot(theta_exp.("V" + num2str(i)), res_s_t.("V" + num2str(i)))
end
ylim([-50, 45])
plot([0,theta_exp.("V" + num2str(5))(end)],[0,0],'LineStyle','--')
legend("5.5V", "6.5V", "7.5V", "8.5V", "9.5V", "10.5V", "zero")
