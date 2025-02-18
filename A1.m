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
dT = 0.1;
t = 0:dT:10;
T = 0.1;

kt = 0:T:10;

% Input vector - sin(t); 0 <= t <= pi
u = zeros(size(t));
u(t <= pi) = sin(t(t <= pi));

% Create SS models and simulate
sys = ss(A,B,C,D);

sim_result = lsim(sys,u,t,xo);

% Create discrete-time SS model
sysd = c2d(sys,T);

% Discrete-time and input vectors
x_k = zeros(2, length(kt));
x_k(:,1) = [1;1];
u_k = zeros(size(kt));
u_k(kt <= pi) = sin(kt(kt <= pi));


% Update states using previous value
for k = 1:length(kt)-1
    x_k(:,k+1) = sysd.A*x_k(:,k) + sysd.B*u_k(k);
end

figure
plot(t, sim_result(:,1), 'DisplayName', 'x_1 continuous-time')
hold on
plot(kt, x_k(1,:), '-o', 'DisplayName', 'x_1 discrete-time')
plot(t, u, 'DisplayName', 'u continuous-time')
plot(kt, u_k, 'o', 'DisplayName', 'u discrete-time')
legend
xlabel("time")


figure
plot(t, sim_result(:,2), 'DisplayName', 'x_2 continuous-time')
hold on
plot(kt, x_k(2,:), '-o', 'DisplayName', 'x_2 discrete-time')
plot(t, u, 'DisplayName', 'u continuous-time')
plot(kt, u_k, 'o', 'DisplayName', 'u discrete-time')
legend
xlabel("time")
