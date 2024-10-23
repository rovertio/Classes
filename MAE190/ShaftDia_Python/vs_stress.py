import numpy as np

# Function for calculating the von mises stress from the applied/design
# loads onto the shaft. Verifies factor of safety for yielding
# Inputs: 
#   shaft_d     Shaft diameter (smaller one)
#   Ma          Moment amplitude
#   Mm          Moment mean
#   Ta          Torque amplitude
#   Tm          Torque mean
#   Kf          Stress concentration normal
#   Kfs         Stress concentration shear
#   Sy          Yielding strength
# Outputs: 
#   vsi_a       Von mises stress amplitude
#   vsi_m       Von mises stress mean
#   ny          Yielding factor of safety (conservative)

def vs_stress(shaft_d, Ma, Mm, Ta, Tm, Kf, Kfs, Sy):

    # Stresses for circular cross-section shaft
    # Alternating
    sig_a = Kf*((32*Ma)/(np.pi*shaft_d^3))
    tor_a = Kfs*((16*Ta)/(np.pi*shaft_d^3))
    # Mid-range
    sig_m = Kf*((32*Mm)/(np.pi*shaft_d^3))
    tor_m = Kfs*((16*Tm)/(np.pi*shaft_d^3))

    # Calculation of Von Mises stresses
    vsi_a = ((sig_a^2) + 3*(tor_a^2))^(1/2)
    vsi_m = ((sig_m^2) + 3*(tor_m^2))^(1/2)

    # Testing for yielding (conservative test)
    ny = Sy/(vsi_a + vsi_m)

    return vsi_a, vsi_m, ny


