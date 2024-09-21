G=6.67*10^-11;
Ms=1.99*10^30;
Re=150.7*10^9;
Rm=243.33*10^9;
k=sqrt(G*Ms);
p=1.8612365*10^11;
Ve=sqrt(G*Ms/Re);

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
L=ceil(Thal/(60*60*24));
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
    
Vs0=vt(1)-Ve;
    figure(2)
for i=1:L
    %Asa = sum(Wsa(1:i))*60*60*24;
    %aa(i)=Asa;

    subplot(1,2,1)
    polarplot(Ae(i),re(i),'or','MarkerSize',5,'MarkerFaceColor','r')
    polarplot(Am(i),rm(i),'or','MarkerSize',5,'MarkerFaceColor','g')
    polarplot(stt(i),rsa(i),'or','MarkerSize',5,'MarkerFaceColor','g')
    hold on
    polarplot(Ae(1:i),re(1:i),'linewidth',2)
    polarplot(Am(1:i),rm(1:i),'linewidth',2)
    polarplot(stt(1:i),rsa(1:i),'linewidth',2)
    title('Trans Martian Trajectory')
    %legend([a1,a2,a3],'trajectory of Earth','Trajectory of Mars','Trajectory of Satellite')
    subplot(1,2,2)
    axis([1.5*10^11 2.5*10^11, 2*10^4 3.5*10^4])
    hold on
    plot(rsa(i),vt(i),'ob','MarkerSize',5,'MarkerFaceColor','g')
    plot(rsa(1:i),vt(1:i),'linewidth',2)

    title('Velocity Of Satellite Relative to Sun')
    xlabel('Distance from Sun')
    ylabel('Speed of Satellite')
    grid on
    pause(0.05)
%
    if i~=L
        clf
    end
end

