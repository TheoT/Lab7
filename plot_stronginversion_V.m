clear all; clc; clf; hold on;

load V=2V_V_meas_strong
V_2V        = V;
V_diff_1    = V_src;

load V=3V_V_meas_strong
V_3V        = V;
V_diff_2    = V_src;

load V=4V_V_meas_strong
V_4V        = V;
V_diff_3    = V_src;

plot(V_diff_1, V_2V,'b.');
plot(V_diff_2, V_3V,'r.');
plot(V_diff_3, V_4V,'k.');

axis([-.35 .35 .7 3.2])
xlabel 'V_{dm} (V)'
ylabel 'V (V)'
title('Common Node Voltage Sweeping V_{dm}, Strong Inversion', 'fontsize',20)
legend('V_2=2V','V_2=3V','V_2=4V','location','northwest')

print '-depsc' plot_strong_v
