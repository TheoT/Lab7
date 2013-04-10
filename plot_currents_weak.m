clear all
load('V=2V_measI1_weak.mat');
load('V=2V_measI2_weak.mat');
figure(1);
plot(V_diff,I1,'ob'); hold on;
plot(V_diff,I2,'or'); 
plot(V_diff,I1-I2,'ok');
plot(V_diff,I1+I2,'og'); 

I_diff=I1-I2;
inds=intersect(find(.05>V_diff),find(V_diff>-.05));
p=polyfit(V_diff(inds),I_diff(inds),1);
'Transconductance Gain 2V'
p(1)

clear all
load('V=3V_measI1_weak.mat');
load('V=3V_measI2_weak.mat');
figure(1);
plot(V_diff,I1,'.b'); hold on;
plot(V_diff,I2,'.r'); 
plot(V_diff,I1-I2,'.k');
plot(V_diff,I1+I2,'.g'); 

I_diff=I1-I2;
inds=intersect(find(.05>V_diff),find(V_diff>-.05));
p=polyfit(V_diff(inds),I_diff(inds),1);
'Transconductance Gain 3V'
p(1)

clear all
load('V=4V_measI1_weak.mat');
load('V=4V_measI2_weak.mat');
figure(1);
plot(V_diff,I1,'*b'); hold on;
plot(V_diff,I2,'*r'); 
plot(V_diff,I1-I2,'*k');
plot(V_diff,I1+I2,'*g'); 

I_diff=I1-I2;
inds=intersect(find(.05>V_diff),find(V_diff>-.05));
p=polyfit(V_diff(inds),I_diff(inds),1);
'Transconductance Gain 3V'
p(1)

axis([-.3 .3 -2.5e-6 2.5e-6])

legend('I1 2V','I2 2V','I1-I2 2V','I1+I2 2V','I1 3V','I2 3V','I1-I2 3V','I1+I2 3V','I1 4V','I2 4V','I1-I2 4V','I1+I2 4V','location','best')

title('I_1 and I_2 With Weakly Inverted Bias Transistor','FontSize',14);
xlabel('V_{DM}','FontSize',14);
ylabel('I','FontSize',14)

print '-depsc' currents_strong
saveas(gcf,'currents_weak.png')
