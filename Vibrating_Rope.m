% Parameters
L = 2 * pi;   
T = 10;       
c = 1;        
Nx = 200;     
Nt = 2000;    
dx = L / Nx;  
dt = T / Nt;  

% Stability condition
if c * dt / dx > 1
    error('The scheme is unstable');
end

% Create grid
x = linspace(0, L, Nx+1);
t = linspace(0, T, Nt+1);

% Initial condition: step function
u_initial = @(x) double((x >= 0) & (x < pi));
u = u_initial(x);

% Initialize the solution matrix
U = zeros(Nx+1, Nt+1);
U(:, 1) = u;

% Apply the initial velocity condition (u_t(x,0) = 0)
U(:, 2) = U(:, 1);  % Initial velocity is zero, same as initial displacement

% Coefficient for finite difference
alpha = (c * dt / dx)^2;

% Finite difference scheme initialization
for i = 2:Nx
    U(i, 2) = U(i, 1) + 0.5 * alpha * (U(i+1, 1) - 2 * U(i, 1) + U(i-1, 1));
end

% Boundary conditions
U([1, Nx+1], 2) = 0;  % Fixed ends

% Finite difference scheme (leapfrog method)
for n = 2:Nt
    U(2:Nx, n+1) = 2 * U(2:Nx, n) - U(2:Nx, n-1) + alpha * (U(3:Nx+1, n) - 2 * U(2:Nx, n) + U(1:Nx-1, n));
    U([1, Nx+1], n+1) = 0;  % Fixed ends
end

% Plot the initial and final state of the rope
figure;
plot(x, U(:, 1), 'b', 'LineWidth', 2); hold on;
plot(x, U(:, end), 'r', 'LineWidth', 2);
legend('Initial State', 'Final State');
xlabel('x');
ylabel('u(x, t)');
title('Vibrating Rope - Wave Equation Solution');
grid on;

% Animate the wave motion
figure;
for n = 1:Nt+1
    plot(x, U(:, n), 'b', 'LineWidth', 2);
    axis([0 L -1.5 1.5]);
    xlabel('x');
    ylabel('u(x, t)');
    title(sprintf('Time = %.2f', t(n)));
    grid on;
    pause(0.01);
end
