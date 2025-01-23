clc; clear;

syms t

A = [-2, -2;
     1 ,  0];

B = [1;
     0];

C = [1, 0;
     0, 1];

D = 0;

xo = [1;
      1];

dT = 0.01;
t = 0:dT:10;

u = zeros(size(t));
u(t <= pi) = sin(t(t <= pi));


sys = ss(A,B,C,D);

lsim(sys,u,t,xo);


