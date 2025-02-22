clc; clear;

%%% Problem 3 %%%%

% a)

A = [2,-1;1,0];
B = [1;0];
C = [1,-1];

kd_a = kalman(A,B,C);
disp("3 a) T inverse")
disp(kd_a.T_inv)
disp("transformed state vector entries")
disp("    zco   zc_o  z_co  z_c_o")
disp(kd_a.z_dim)

% b)

A = [1,0,0;0,1,1;1,0,-1];
B = [0;0;1];
C = [0,0,1];

kd_b = kalman(A,B,C);
disp("3 b) T inverse")
disp(kd_b.T_inv)
disp("transformed state vector entries")
disp("    zco   zc_o  z_co  z_c_o")
disp(kd_b.z_dim)


