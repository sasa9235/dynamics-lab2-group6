clc
clear
close all

%% General Parameter
theta = 0:0.01:360*6;
r = 7.5/100;
d = 15.5/100;
l = 26/100;
delta_measurment = 0.05/100;


%% Process datas
[theta_exp_5, w_exp_5, v_exp_5, time_5] = LCSDATA("Locomotive_Data_2020\Test1_5pt5V");
[theta_exp_6, w_exp_6, v_exp_6, time_6] = LCSDATA("Locomotive_Data_2020\Test1_6pt5V");
[theta_exp_7, w_exp_7, v_exp_7, time_7] = LCSDATA("Locomotive_Data_2020\Test1_7pt5V");
[theta_exp_8, w_exp_8, v_exp_8, time_8] = LCSDATA("Locomotive_Data_2020\Test1_8pt5V");
[theta_exp_9, w_exp_9, v_exp_9, time_9] = LCSDATA("Locomotive_Data_2020\Test1_9pt5V");
[theta_exp_10, w_exp_10, v_exp_10, time_10] = LCSDATA("Locomotive_Data_2020\Test1_10pt5V");

% Find mean angular verlocity
w_5 = mean(w_exp_5)/180 * pi;
w_6 = mean(w_exp_6)/180 * pi;
w_7 = mean(w_exp_7)/180 * pi;
w_8 = mean(w_exp_8)/180 * pi;
w_9 = mean(w_exp_9)/180 * pi;
w_10 = mean(w_exp_10)/180 * pi;


%% Calculate Model
v_mod_5 = LCSMODEL(r, d, l, theta, w_5);
v_mod_6 = LCSMODEL(r, d, l, theta, w_6);
v_mod_7 = LCSMODEL(r, d, l, theta, w_7);
v_mod_8 = LCSMODEL(r, d, l, theta, w_8);
v_mod_9 = LCSMODEL(r, d, l, theta, w_9);
v_mod_10 = LCSMODEL(r, d, l, theta, w_10);

%% Calculate Residual
theta_5 = time_5 * w_5 / pi * 180 + theta_exp_5(1);
res_5 = v_exp_5 * 10^-3 - LCSMODEL(r, d, l, theta_5, w_5);

theta_6 = time_6 * w_6 / pi * 180 + theta_exp_6(1);
res_6 = v_exp_6 * 10^-3 - LCSMODEL(r, d, l, theta_6, w_6);

theta_7 = time_7 * w_7 / pi * 180 + theta_exp_7(1);
res_7 = v_exp_7 * 10^-3 - LCSMODEL(r, d, l, theta_7, w_7);

theta_8 = time_8 * w_8 / pi * 180 + theta_exp_8(1);
res_8 = v_exp_8 * 10^-3 - LCSMODEL(r, d, l, theta_8, w_8);

theta_9 = time_9 * w_9 / pi * 180 + theta_exp_9(1);
res_9 = v_exp_9 * 10^-3 - LCSMODEL(r, d, l, theta_9, w_9);

theta_10 = time_10 * w_10 / pi * 180 + theta_exp_10(1);
res_10 = v_exp_10 * 10^-3 - LCSMODEL(r, d, l, theta_10, w_10);

%{
figure("Name",'bingus')
hold on
plot(time_10, v_exp_10 * 10^-3)
plot(time_10, LCSMODEL(r, d, l, theta_10, w_10))
%}

%{
res_6 = v_exp_6 - v_mod_6;
res_7 = v_exp_7 - v_mod_7;
res_8 = v_exp_8 - v_mod_8;
res_9 = v_exp_9 - v_mod_9;
res_10 = v_exp_10 - v_mod_10;
%}

%% Plot
figure("Name", "5pt5V")
hold on
plot(theta, v_mod_5)
plot(theta_exp_5, v_exp_5 * 10^-3)
xlim([0,360*6.5])
hold off
figure("Name", "5pt5V residual")
plot(time_5, res_5)

figure("Name", "6pt5V")
hold on
plot(theta, v_mod_6)
plot(theta_exp_6, v_exp_6 * 10^-3)
xlim([0,360*6.5])
hold off
figure("Name", "5pt5V residual")
plot(time_6, res_6)

figure("Name", "7pt5V")
hold on
plot(theta, v_mod_7)
plot(theta_exp_7, v_exp_7 * 10^-3)
xlim([0,360*6.5])
hold off
figure("Name", "5pt5V residual")
plot(time_7, res_7)

figure("Name", "8pt5V")
hold on
plot(theta, v_mod_8)
plot(theta_exp_8, v_exp_8 * 10^-3)
xlim([0,360*6.5])
hold off
figure("Name", "5pt5V residual")
plot(time_8, res_8)

figure("Name", "9pt5V")
hold on
plot(theta, v_mod_9)
plot(theta_exp_9, v_exp_9 * 10^-3)
xlim([0,360*6.5])
hold off
figure("Name", "5pt5V residual")
plot(time_9, res_9)

figure("Name", "10pt5V")
hold on
plot(theta, v_mod_10)
plot(theta_exp_10, v_exp_10 * 10^-3)
xlim([0,360*6.5])
hold off
figure("Name", "5pt5V residual")
plot(time_10, res_10)