
clear all
load('V=2V_I1_meas_strong.mat');
I1a=I1;
load('V=2V_I2_meas_strong.mat');
figure(1);
plot(V_src,I1a,'ob'); hold on;
plot(V_src,I1,'or'); 
plot(V_src,I1a-I1,'ok');
plot(V_src,I1a+I1,'og'); 

clear all
load('V=3V_I1_meas_strong.mat');
I1a=I1;
load('V=3V_I2_meas_strong.mat');
figure(1);
plot(V_src,I1a,'.b'); hold on;
plot(V_src,I1,'.r'); 
plot(V_src,I1a-I1,'.k');
plot(V_src,I1a+I1,'.g'); 

clear all
load('V=4V_I1_meas_strong.mat');
I1a=I1;
load('V=4V_I2_meas_strong.mat');
figure(1);
plot(V_src,I1a,'*b'); hold on;
plot(V_src,I1,'*r'); 
plot(V_src,I1a-I1,'*k');
plot(V_src,I1a+I1,'*g'); 
legend('I1','I2','I1-I2','I1+I2','location','best')

title('Currents as a function of V_{DM}','FontSize',14);
xlabel('V_{DM}','FontSize',14);
ylabel('I','FontSize',14)

print '-depsc' currents_strong
saveas(gcf,'currents_strong.png')
