G=6.67*10^-11;
Ms=1.99*10^30;
Re=150.7*10^9;
Rm=243.33*10^9;
k=sqrt(G*Ms);
p=1.8612365*10^11;
m=0.23506;

Thal = 0.5*sqrt(4*pi^2*((Re+Rm)/2)^3/(k^2));
B=-G*Ms*(1/Re-1/Rm);
v2=sqrt(2*B/(1-Rm^2/Re^2));
v1=Rm*v2/Re;
h=Re*v1;
H=0.5*v1^2-G*Ms/Re;
Wm=(G*Ms/Rm^3)^(1/2);
We=(G*Ms/Re^3)^(1/2);
Tm0=180-Wm*Thal*180/pi;
L=300;
t=0:L;
Ae=We*60*60*24.*t;
Am=0.8528+Wm*60*60*24.*t;
re=Re.*t.^0;
rm=Rm.*t.^0;
%rsa = p./(1+m.*cos(t));
%Wsa = h.*rsa.^-2;
st=0;
for tt=1:L
    rsa(tt) = p/(1+m*cos(st));
    Wssa = h/rsa(tt)^2;
    teta=Wssa*60*60*24;
    st = st+teta;
    stt(tt)=st;
    vt(tt)=sqrt(2*(H+G*Ms/rsa(tt)));
end
    


for i=1:L
    %Asa = sum(Wsa(1:i))*60*60*24;
    %aa(i)=Asa;
    polarplot(Ae(i),re(i),'or','MarkerSize',5,'MarkerFaceColor','r')
    polarplot(Am(i),rm(i),'or','MarkerSize',5,'MarkerFaceColor','g')
    polarplot(stt(i),rsa(i),'or','MarkerSize',5,'MarkerFaceColor','g')
    hold on
    polarplot(Ae(1:i),re(1:i),'linewidth',2)
    polarplot(Am(1:i),rm(1:i),'linewidth',2)
    polarplot(stt(1:i),rsa(1:i),'linewidth',2)
    pause(0.05)
%
    if i~=length(t)
        clf
    end
end

for i=1:L
        figure(2)
    hold on
    plot(rsa(i),vt(i),'or','MarkerSize',5,'MarkerFaceColor','g')
    plot(rsa(1:i),vt(1:i),'linewidth',2)
    hold off
    pause(0.05)
end
