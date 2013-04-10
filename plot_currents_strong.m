
clear all
load('V=2V_I1_meas_strong.mat');
I1a=I1;
load('V=2V_I2_meas_strong.mat');
figure(1);
plot(V_src,I1a,'ob'); hold on;
plot(V_src,I1,'or'); 
plot(V_src,I1a-I1,'ok');
plot(V_src,I1a+I1,'og'); 
I_diff=I1a-I1;
inds=intersect(find(.05>V_src),find(V_src>-.05));
p=polyfit(V_src(inds),I_diff(inds),1);
'Transconductance Gain 2V'
p(1)

clear all
load('V=3V_I1_meas_strong.mat');
I1a=I1;
load('V=3V_I2_meas_strong.mat');
figure(1);
plot(V_src,I1a,'.b'); hold on;
plot(V_src,I1,'.r'); 
plot(V_src,I1a-I1,'.k');
plot(V_src,I1a+I1,'.g'); 
I_diff=I1a-I1;
inds=intersect(find(.05>V_src),find(V_src>-.05));
p=polyfit(V_src(inds),I_diff(inds),1);
'Transconductance Gain 3V'
p(1)

clear all
load('V=4V_I1_meas_strong.mat');
I1a=I1;
load('V=4V_I2_meas_strong.mat');
figure(1);
plot(V_src,I1a,'*b'); hold on;
plot(V_src,I1,'*r'); 
plot(V_src,I1a-I1,'*k');
plot(V_src,I1a+I1,'*g'); 

I_diff=I1a-I1;
inds=intersect(find(.05>V_src),find(V_src>-.05));
p=polyfit(V_src(inds),I_diff(inds),1);
'Transconductance Gain 4V'
p(1)

legend('I1 2V','I2 2V','I1-I2 2V','I1+I2 2V','I1 3V','I2 3V','I1-I2 3V','I1+I2 3V','I1 4V','I2 4V','I1-I2 4V','I1+I2 4V','location','best')

title('I_1 and I_2 With Strongly Inverted Bias Transistor','FontSize',14);
xlabel('V_{DM}','FontSize',14);
ylabel('I','FontSize',14)

print '-depsc' currents_strong
saveas(gcf,'currents_strong.png')
