%% P1

figure(1);
g1 = tf([0.1],[1,0.1]);
bode(g1)

figure(2);
g2 = tf([0.1],[1,0.1],'InputDelay',6);
bode(g2)


%% P4

p_delay = tf([1,-1,1/3],[1,1,1/3]);
% Root Locus for finding w_u
g_approx = g1*p_delay;
rlocus(g_approx)
% bode(g_approx)

%% P4a
alpha = 0.6;
beta = 0.5;
gamma = 0.125;
Ku = 3.33;
wu = 0.317;

Kp = alpha*Ku;
Ti = 0.5/0.317;
Td = 0.125/0.317;
pid_prob = tf([Kp*Td, Kp, Kp/Ti], [1, 0]);

% function with pade approximation
%ol_pid = g_approx*pid_prob;
% function with exact representation of delay
ol_pid = g2*pid_prob;

bode(ol_pid)
margin(ol_pid);
%[gm, pm, wp, wc] = margin(ol_pid);

%% P6

dt_tra = c2d(g1,2);
