clc; clear;

%%% Problem 3 %%%%

% a)

A = [2,-1;1,0];
B = [1;0];
C = [1,-1];

kd_1 = kalman(A,B,C);

A = [1,0,0;0,1,1;1,0,-1]
B = [0;0;1]
C = [0,0,1]

kd = kalman(A,B,C)

A = [1,0,1;0,-1,1;0,0,1];
B = [1;0;0];
C = [0,1,0];

kd = kalman(A,B,C)
