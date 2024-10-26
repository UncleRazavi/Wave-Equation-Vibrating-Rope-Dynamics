
# Wave Equation Solution Using Finite Difference Method

This document provides a MATLAB implementation of the wave equation using the finite difference method, specifically the leapfrog scheme. The code has been optimized for clarity and efficiency.

## Parameters
The following parameters define the system:

- `L`: Length of the rope (2 * pi)
- `T`: Total time duration (10)
- `c`: Wave speed (1)
- `Nx`: Number of spatial discretization points (200)
- `Nt`: Number of time steps (2000)
- `dx`: Spatial step size (`L / Nx`)
- `dt`: Temporal step size (`T / Nt`)

## Stability Condition
The code checks for stability using the condition:
- If `c * dt / dx > 1`, an error is raised, indicating that the scheme is unstable.

## Initial Conditions
A step function is used as the initial condition for the displacement:

```matlab
u_initial = @(x) double((x >= 0) & (x < pi));
```
The initial velocity is set to zero.
