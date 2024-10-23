#!/usr/bin/env python3
# A16351004 #PID

import numpy as np
import scipy.stats as sp

def prob(w, ss):

    coef = 1/(np.sqrt(2*np.pi*ss))
    eval = np.exp(-((np.square(w))/(2*ss)))

    return coef*eval

def landmark_sensor_model(z, x, l):
    # z is your range and bearing, x robot pose, l is the landmark
    # position you can make use of a built in python in python to
    # compute your noise samples

    # define variables
    srs = 0.25
    sts = 0.01
    rhat = np.sqrt(np.square(l[0] - x[0]) + np.square(l[1] - x[1]))
    phihat = np.arctan2((l[1] - x[1]), (l[0] - x[0])) - x[2]

    # compute your likelhood
    p_r = prob((z[0] - rhat), srs)
    p_t = prob((z[1] - phihat), sts)
    # print(p_r)
    # print(p_t)
    
    likelihood = (p_r)*(p_t)
    
    return likelihood


if __name__ == '__main__':

    x = [2, 3, np.pi/4]
    l = [2, 8]
    z0 = [5.0, np.pi/4]
    z1 = [5.0, 0.6]
    z2 = [4.5, np.pi/4]
    z3 = [5.5, 0.9]


    p0 = landmark_sensor_model(z0, x, l)
    print("Probability of z0: " + str(p0))

    p1 = landmark_sensor_model(z1, x, l)
    print("Probability of z1: " + str(p1))

    p2 = landmark_sensor_model(z2, x, l)
    print("Probability of z2: " + str(p2))

    p3 = landmark_sensor_model(z3, x, l)
    print("Probability of z3: " + str(p3))



