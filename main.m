clc
clear
close all

%% General Parameter
% measured parameter w/ uncertainty
r = 7.5;
d = 15.5;
l = 26;
delta_measurment = 0.05;


%% Process datas
% for naming purpose
Volt = ["5.5V", "6.5V", "7.5V", "8.5V", "9.5V", "10.5V"];

% call LCS DATA to save theta, w, v, time from each experiment into a
% common struct structure
for i = 5:10
    [theta_exp.("V" + num2str(i)), w_exp.("V" + num2str(i)), v_exp.("V" + num2str(i)), time_exp.("V" + num2str(i))] = LCSDATA("Locomotive_Data_2020\Test1_" + num2str(i) + "pt5V");
end

%% Validate Model

% pick a omega to validate and convert to degrees/s
w = 10 / pi * 180;
% theta used for validating
theta_v = 0:0.5:360*6;
% calculate V collar with validating input for LCSMODEL
v_mod_v = LCSMODEL(r, d, l, theta_v, w * ones(size(theta_v)));


%% Calculate Model
% calculate V collar with LCSMODEL for each experiment given corresponding
% theta and mean omega and saved into v_mod struct
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
    res_s_t.("V" + num2str(i)) = v_exp.("V" + num2str(i)) * 10^-1 - v_mod.("V" + num2str(i)); % mean theta
end


%% Plot

% V_model vs Theta Plot
figure("Name", "Model Validation Data", "Position", [550,200,800,480])
title("Model Validation Data")
hold on
plot(theta_v, v_mod_v)
xlim([0,360*6.5])
ylim([-200, 250])
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity (v_B_,_y) [m/s]')
hold off

% V_model & V_actual vs Theta Plot
figure("Name", "Model vs Experimental Data", "Position", [550,200,800,480])
% loop through theta_exp,v_mod,v_exp strut to plot comparison
for i=5:10
    subplot(2,3,i-4)
    title("Model vs Experimental Data " + Volt(i-4))
    hold on
    % model
    plot(theta_exp.("V" + num2str(i)), v_mod.("V" + num2str(i)))
    % experimental 
    plot(theta_exp.("V" + num2str(i)), v_exp.("V" + num2str(i)) * 10^-1)
    xlim([0,360*6.5])
    ylim([-200, 330])
    xlabel('Wheel Angular Position [degree]')
    ylabel('Coller Velocity (v_B_,_y) [m/s]')
    legend("Model", "Experimental")
    hold off
end


sign_mean = zeros(1,6); % pre-allociate space for means and std calculation
sign_std = zeros(1,6);
% Sign Residual vs Time
figure("Name", "Signed Residuals vs Time", "Position", [550,200,800,480])
% loop through time_exp and res_s struct to create 6 subplot of different
% residuals vs time for each voltage
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

% Table for Signed Residual
% dimention of table
sz = [6, 3];
% defined variable types for table (will reuse later)
varTypes = ["string","double","double"];
% defined collum names for table (will reuse later)
varNames = ["Voltage","mean","standard deviation"];
% create table
mean_std_table = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

% init means and stds strings to store 2 sig fig means and std
means = strings(1,6);
stds = means;
% calculate and store 2 sig fig means and std for each voltage
for i = 1:6
    means(i) = char(vpa(sign_mean(i), 2));
    stds(i) = char(vpa(sign_std(i), 2));
end
% store into table
for i = 1:6
    mean_std_table(i,:) = {Volt(i), means(i), stds(i)};
end

% Display table (signed res)
disp(mean_std_table)



abs_mean = zeros(1,6); % pre-allociate space for means and std calculation
abs_std = zeros(1,6);
% Absolute Residual vs Time
figure("Name", "Absolute Residuals vs Time", "Position", [550,200,800,480])
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
    abs_mean(i-4) = mean(abs(res_s.("V" + num2str(i))));
    abs_std(i-4) = std(abs(res_s.("V" + num2str(i))));
    hold off
end


% Table for Absolute Residual
% create table
abs_mean_std_table = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
% init strings to store 2 sig fig abs_means and abs_std
abs_means = strings(1,6);
abs_stds = abs_means;
% calculate and store 2 sig fig means and std for each voltage
for i = 1:6
    abs_means(i) = char(vpa(abs_mean(i), 2));
    abs_stds(i) = char(vpa(abs_std(i), 2));
end
% store into table
for i = 1:6
    abs_mean_std_table(i,:) = {Volt(i), abs_means(i), abs_stds(i)}; % Use correct variables
end

% Display table (abs res)
disp(abs_mean_std_table)



% Both Residual vs Time Plot
figure("Name", "Sign and Absolute Residuals vs Time (7.5V)", "Position", [550,200,800,480])
title("Sign and Absolute Residuals vs Time (7.5V)")
hold on
plot(time_exp.("V" + num2str(7)), res_s.("V" + num2str(7)))
plot(time_exp.("V" + num2str(7)), abs(res_s.("V" + num2str(7))))
plot([0,time_exp.("V" + num2str(7))(end)],[0,0],'LineStyle','--') % zero line
ylim([-20, 20])
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
legend('sign', 'absolute')
hold off

% Signed Residual vs Time Comparison
figure("Name", "Signed Residuals vs Time Comparison", "Position", [550,200,800,480])
title("Signed Residuals vs Time Comparison")
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
hold on
% loop through time_exp, res_s struct to plot signed res vs time for all
% voltage
for i=5:10
    plot(time_exp.("V" + num2str(i)), res_s.("V" + num2str(i)))
end
ylim([-25, 20])
xlim([0,7])
plot([0,theta_exp.("V" + num2str(5))(end)],[0,0],'LineStyle','--')
legend("5.5V", "6.5V", "7.5V", "8.5V", "9.5V", "10.5V", "zero")

% Signed Residual vs Theta
figure("Name", "Signed Residuals vs Theta", "Position", [550,200,800,480])
title("Signed Residuals vs Wheel Angular Position")
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity Residual (\Deltav_B_,_y) [m/s]')
hold on
% loop through theta_exp, res_s_t struct to plot signed res vs theta for all
% voltage
for i=5:10
    plot(theta_exp.("V" + num2str(i)), res_s_t.("V" + num2str(i)))
end
ylim([-50, 45])
plot([0,theta_exp.("V" + num2str(5))(end)],[0,0],'LineStyle','--')
legend("5.5V", "6.5V", "7.5V", "8.5V", "9.5V", "10.5V", "zero")
