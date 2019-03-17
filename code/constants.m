% This script containts all the constants used in the simulation so that
% this script can be run anywhere to get all the constants. Its much nicer
% then using a bunch of constant global functions

% Physical constants
C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light

% System Paramaters
T = 300; % K, Temperature
mn = 0.26*C.m_0; % effective mass of electron
Tmn = 0.2E-12; % s, mean time between collisions
V0 = 0.1; % Differential Voltage

% Material Properties
sigma_conduct = 1; % Moh
sigma_insulate = 1E-2; % Mho

% Simulation bounds
size_x = 200E-9; % m
size_y = 200E-9; % m

% Simulation grid size
nx = 75;
ny = 50;

% Simulation Runtime
steps = 1000; % Run simulation for 100 steps
dt = 200E-9/1E8; % s, simulation step time
N = 10000; % Number of particles
N_plot = 10; % Number of particles to show in motion plot

% Collision Type
collision_type = 0; % 0 = specular, 1 = diffusive

% Calculated values
vth = sqrt(2*physconst('Boltzmann')*T/mn); % mean thermal velocity
lambda = vth*Tmn; % mean free path
Pscat = 1 - exp(-dt/Tmn);
