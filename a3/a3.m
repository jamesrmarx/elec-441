clc; clear;


%%% Problem 2 %%%
Gs.a = tf(1,[1 0]);
Gs.b = tf(1,[1 2 0]);
Gs.c = [tf(1,[1 0 0]) tf(1,[1 2 0])];
Gs.d = [tf(1,[1 0 0]); tf(1,[1 2 0])];
Gs.e = [tf(1,[1 0]) tf(1,[1 0]); tf(1,[1 0]) tf(1,[1 1])];

sys.a = minreal(ss(Gs.a));
sys.b = minreal(ss(Gs.b));
sys.c = minreal(ss(Gs.c));
sys.d = minreal(ss(Gs.d));
sys.e = minreal(ss(Gs.e));

clc;

fprintf('1 a) minimal realization A matrix has dimensions: %d x %d\n', size(sys.a.A,1), size(sys.a.A,2));
fprintf('1 b) minimal realization A matrix has dimensions: %d x %d\n', size(sys.b.A,1), size(sys.b.A,2));
fprintf('1 c) minimal realization A matrix has dimensions: %d x %d\n', size(sys.c.A,1), size(sys.c.A,2));
fprintf('1 d) minimal realization A matrix has dimensions: %d x %d\n', size(sys.d.A,1), size(sys.d.A,2));
fprintf('1 e) minimal realization A matrix has dimensions: %d x %d\n', size(sys.e.A,1), size(sys.e.A,2));

