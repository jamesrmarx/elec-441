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

% Input vector - sin(t); 0 <= t <= pi
u = zeros(size(t));
u(t <= pi) = sin(t(t <= pi));


sys = ss(A,B,C,D);

lsim(sys,u,t,xo);


