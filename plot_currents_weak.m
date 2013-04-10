clear all
load('V=2V_I1_meas_weak.mat');
load('V=2V_I2_meas_weak.mat');
figure(1);
plot(V_diff,I1,'ob'); hold on;
plot(V_diff,I2,'or'); 
plot(V_diff,I1-I2,'ok');
plot(V_diff,I1+I2,'og'); 
legend('I1','I2','I1-I2','I1+I2','location','best')

clear all
load('V=3V_I1_meas_weak.mat');
load('V=3V_I2_meas_weak.mat');
figure(1);
plot(V_diff,I1,'.b'); hold on;
plot(V_diff,I2,'.r'); 
plot(V_diff,I1-I2,'.k');
plot(V_diff,I1+I2,'.g'); 
legend('I1','I2','I1-I2','I1+I2','location','best')

% clear all
% load('V=4V_I1_meas_weak.mat');
% I1=I2;
% load('V=4V_I2_meas_weak.mat');
% figure(1);
% plot(V_src,I1,'*b'); hold on;
% plot(V_src,I2,'*r'); 
% plot(V_src,I1-I2,'*k');
% plot(V_src,I1+I2,'*g'); 
% legend('I1','I2','I1-I2','I1+I2','location','best')
