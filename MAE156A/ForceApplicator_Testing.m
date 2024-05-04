%% Setup

clear all


s = serialport("COM8", 9600);

%%

flush(s)
data = read(s,1000,"uint64")';
reading = mean(data);