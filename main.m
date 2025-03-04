clc
clear
close all

%% General Parameter
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


%% Calculate Model
v_mod_5 = LCSMODEL(r, d, l, theta_exp_5, w_exp_5);
v_mod_6 = LCSMODEL(r, d, l, theta_exp_6, w_exp_6);
v_mod_7 = LCSMODEL(r, d, l, theta_exp_7, w_exp_7);
v_mod_8 = LCSMODEL(r, d, l, theta_exp_8, w_exp_8);
v_mod_9 = LCSMODEL(r, d, l, theta_exp_9, w_exp_9);
v_mod_10 = LCSMODEL(r, d, l, theta_exp_10, w_exp_10);

%% Calculate Residual
res_5 = v_exp_5 * 10^-3 - LCSMODEL(r, d, l, theta_exp_5, w_exp_5);
res_6 = v_exp_6 * 10^-3 - LCSMODEL(r, d, l, theta_exp_6, w_exp_6);
res_7 = v_exp_7 * 10^-3 - LCSMODEL(r, d, l, theta_exp_7, w_exp_7);
res_8 = v_exp_8 * 10^-3 - LCSMODEL(r, d, l, theta_exp_8, w_exp_8);
res_9 = v_exp_9 * 10^-3 - LCSMODEL(r, d, l, theta_exp_9, w_exp_9);
res_10 = v_exp_10 * 10^-3 - LCSMODEL(r, d, l, theta_exp_10, w_exp_10);

%% Plot
figure("Name", "Model vs Actual")
subplot(3,2,1);
hold on
title("5.5V")
plot(theta_exp_5, v_mod_5)
plot(theta_exp_5, v_exp_5 * 10^-3)
xlim([0,360*6.5])
ylim([-2.5, 2.5])
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity (v_B_,_y) [m/s]')
legend("Model", "Experimental")
hold off

subplot(3,2,2);
hold on
title("6.5V")
plot(theta_exp_6, v_mod_6)
plot(theta_exp_6, v_exp_6 * 10^-3)
xlim([0,360*6.5])
ylim([-2.5, 2.5])
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity (v_B_,_y) [m/s]')
legend("Model", "Experimental")
hold off

subplot(3,2,3);
hold on
title("7.5V")
plot(theta_exp_7, v_mod_7)
plot(theta_exp_7, v_exp_7 * 10^-3)
xlim([0,360*6.5])
ylim([-2.5, 2.5])
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity (v_B_,_y) [m/s]')
legend("Model", "Experimental")
hold off

subplot(3,2,4);
hold on
title("8.5V")
plot(theta_exp_8, v_mod_8)
plot(theta_exp_8, v_exp_8 * 10^-3)
xlim([0,360*6.5])
ylim([-2.5, 2.5])
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity (v_B_,_y) [m/s]')
legend("Model", "Experimental")
hold off

subplot(3,2,5);
hold on
title("9.5V")
plot(theta_exp_9, v_mod_9)
plot(theta_exp_9, v_exp_9 * 10^-3)
xlim([0,360*6.5])
ylim([-2.5, 2.5])
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity (v_B_,_y) [m/s]')
legend("Model", "Experimental")
hold off

subplot(3,2,6);
hold on
title("10.5V")
plot(theta_exp_10, v_mod_10)
plot(theta_exp_10, v_exp_10 * 10^-3)
xlim([0,360*6.5])
ylim([-2.5, 2.5])
xlabel('Wheel Angular Position [degree]')
ylabel('Coller Velocity (v_B_,_y) [m/s]')
legend("Model", "Experimental")
hold off

figure("Name", "Residual")
subplot(3,2,1);
hold on
title("5.5V")
ylim([-0.4, 0.4])
plot(time_5, res_5)
plot([0,time_5(end)],[0,0],'LineStyle','--')
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Error (\Deltav_B_,_y) [m/s]')
subplot(3,2,2);
ylim([-0.4, 0.4])
hold on
title("6.5V")
plot(time_6, res_6)
plot([0,time_6(end)],[0,0],'LineStyle','--')
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Error (\Deltav_B_,_y) [m/s]')
subplot(3,2,3);
ylim([-0.4, 0.4])
hold on
title("7.5V")
plot(time_7, res_7)
plot([0,time_7(end)],[0,0],'LineStyle','--')
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Error (\Deltav_B_,_y) [m/s]')
subplot(3,2,4);
ylim([-0.4, 0.4])
hold on
title("8.5V")
plot(time_8, res_8)
plot([0,time_8(end)],[0,0],'LineStyle','--')
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Error (\Deltav_B_,_y) [m/s]')
subplot(3,2,5);
ylim([-0.4, 0.4])
hold on
title("9.5V")
plot(time_9, res_9)
plot([0,time_9(end)],[0,0],'LineStyle','--')
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Error (\Deltav_B_,_y) [m/s]')
subplot(3,2,6);
ylim([-0.4, 0.4])
hold on
title("10.5V")
plot(time_10, res_10)
plot([0,time_10(end)],[0,0],'LineStyle','--')
xlabel('Time (t) [sec]')
ylabel('Coller Velocity Error (\Deltav_B_,_y) [m/s]')


