clc; clear;

% Create state matricies
A = [-2, -2;
     1 ,  0];

B = [1;
     0];

C = [1, 0;
     0, 1];

D = 0;

% Initial condition
xo = [1;
      1];

% Set-up time step and time vector
dT = 0.01;
t = 0:dT:10;
T = 0.1;

kt = 0:T:10;

% Input vector - sin(t); 0 <= t <= pi
u = zeros(size(t));
u(t <= pi) = sin(t(t <= pi));


sys = ss(A,B,C,D);

sim_result = lsim(sys,u,t,xo);

sysd = c2d(sys,T);

x_k = zeros(2, length(kt));
% Set initial conditions
x_k(:,1) = [1;1];
u_k = zeros(size(kt));
u_k(kt <= pi) = sin(kt(kt <= pi));

for k = 1:length(kt)-1
    x_k(:,k+1) = sysd.A*x_k(:,k) + sysd.B*u_k(k);
end

figure

subplot(4, 1, 1)
plot(t, sim_result(:,1))
hold on
plot(t, u)

subplot(4, 1, 2)
plot(t, sim_result(:,2))
hold on
plot(t, u)

subplot(4, 1, 3)
plot(kt, x_k(1,:))
hold on
plot(kt, u_k)

subplot(4, 1, 4)
plot(kt, x_k(2,:))
hold on
plot(kt, u_k)

figure
plot(t, sim_result(:,1))
hold on
plot(kt, x_k(1,:), '-o')
plot(t, u)
plot(kt, u_k, 'o')

figure
plot(t, sim_result(:,2))
hold on
plot(kt, x_k(2,:), '-o')
plot(t, u)
plot(kt, u_k, 'o')