clear all; clc; clf; hold on;

load V=2V_V_meas_weak
V_2V        = V;
V_diff_1    = V_diff;

load V=3V_V_meas_weak
V_3V        = V;
V_diff_2    = V_diff;

load V=4V_V_meas_weak
V_4V        = V;
V_diff_3    = V_diff;

plot(V_diff_1, V_2V,'b.');
plot(V_diff_2, V_3V,'r.');
plot(V_diff_3, V_4V,'k.');

axis([-.35 .35 .7 3.6])
xlabel 'V_{dm} (V)'
ylabel 'V (V)'
title('Common Node Voltage Sweeping V_{dm}, Weak Inversion', 'fontsize',20)
legend('V_2=2V','V_2=3V','V_2=4V','location','northwest')

print '-depsc' plot_weak_v
