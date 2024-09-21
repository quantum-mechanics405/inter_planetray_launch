% Constants
G = 6.67 * 10^-11;   % Gravitational constant
Ms = 1.99 * 10^30;   % Mass of the Sun
Re = 150.7 * 10^9;   % Radius of Earth's orbit
Rm = 243.33 * 10^9;  % Radius of Mars' orbit
k = sqrt(G * Ms);    % Gravitational constant times the mass of the Sun
Ve = sqrt(G * Ms / Re); % Escape velocity from Earth

% Satellite properties
m = 0.23506;         % Satellite eccentricity
Thal = 0.5 * sqrt(4 * pi^2 * ((Re + Rm) / 2)^3 / (k^2)); % Thalman's constant
B = -G * Ms * (1 / Re - 1 / Rm); % Specific energy constant
v2 = sqrt(2 * B / (1 - Rm^2 / Re^2)); % Velocity at perihelion
v1 = Rm * v2 / Re;   % Velocity at Earth's orbit
h = Re * v1;         % Specific angular momentum
p=h^2/k^2;   
H = 0.5 * v1^2 - G * Ms / Re; % Specific mechanical energy

% Angular velocities
Wm = (G * Ms / Rm^3)^(1 / 2); % Angular velocity at Mars' orbit
We = (G * Ms / Re^3)^(1 / 2); % Angular velocity at Earth's orbit

% Initial conditions
Tm0 = 180 - Wm * Thal * 180 / pi; % Initial angle at Mars' orbit
L = ceil(Thal / (60 * 60 * 24)); % Number of time steps
t = 0:L;             % Time vector

% Initialize arrays
Ae = We * 60 * 60 * 24 .* t; % Earth's angular position
Am = 0.8528 + Wm * 60 * 60 * 24 .* t; % Mars' angular position
re = Re .* t.^0;     % Earth's orbit radius
rm = Rm .* t.^0;     % Mars' orbit radius

% Initialize variables for satellite trajectory
st = 0;
for tt = 1:L
    rsa(tt) = p / (1 + m * cos(st)); % Satellite's polar radius
    Wssa = h / rsa(tt)^2; % Satellite's angular velocity
    teta = Wssa * 60 * 60 * 24; % Time increment
    st = st + teta; % Update angular position
    stt(tt) = st;   % Store angular positions
    vt(tt) = sqrt(2 * (H + G * Ms / rsa(tt))); % Satellite's velocity
end

% Calculate initial velocity relative to Earth's escape velocity
Vs0 = vt(1) - Ve;


% Plot the satellite trajectory and velocity
figure(2)
set(gcf, 'WindowState', 'maximized');
for i = 1:L
    subplot(1, 2, 1)
    % Plot satellite trajectory on a polar plot
    polarplot(Ae(i), re(i), 'or', 'MarkerSize', 5, 'MarkerFaceColor', 'r')
    polarplot(Am(i), rm(i), 'or', 'MarkerSize', 5, 'MarkerFaceColor', 'g')
    polarplot(stt(i), rsa(i), 'or', 'MarkerSize', 5, 'MarkerFaceColor', 'g')
    hold on
    polarplot(Ae(1:i), re(1:i), 'linewidth', 2)
    polarplot(Am(1:i), rm(1:i), 'linewidth', 2)
    polarplot(stt(1:i), rsa(1:i), 'linewidth', 2)
    title('Trans Martian Trajectory')
    
    subplot(1, 2, 2)
    axis([1.5 * 10^11 2.5 * 10^11, 2 * 10^4 3.5 * 10^4])
    hold on
    % Plot satellite velocity relative to the Sun
    plot(rsa(i), vt(i), 'ob', 'MarkerSize', 5, 'MarkerFaceColor', 'g')
    plot(rsa(1:i), vt(1:i), 'linewidth', 2)
    plot([1.5*10^11 2.5*10^11], [024133 24133], 'b--', 'MarkerSize', 8, 'LineWidth', 2)
    plot([1.5*10^11 2.5*10^11], [29678 29678], 'o--', 'MarkerSize', 8, 'LineWidth', 2)

    title('Velocity Of Satellite Relative to Sun')
    xlabel('Distance from Sun')
    ylabel('Speed of Satellite')
    grid on
    pause(0.05)
    
    % Clear the figure if not the last time step
    if i ~= L
        clf
    end
end


