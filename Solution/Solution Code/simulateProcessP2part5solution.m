%-------------------------------------------------------------------------%
% Function: simulateProcess
%
% Description: Simulates the process from HW11 over a given time horizon
% with random disturbances and measurement noises.
%
% Inputs: None
%
% Outputs: tData - K-dim column vector of time points
%          yData - K-by-ny matrix of output data. The output vector at time
%                  k is stored as the kth row. 
%-------------------------------------------------------------------------%

function [tData,yData] = simulateProcessP2part5solution

    
    %---------------------------------------------------------------------%
    %Problem Set up
    
    %Set problem size
    nx = 5;
    ny = 5;
    nw = 2;
    
    %Set time horizon
    K = 500;
    
    %Set initial conditions
    x0 = zeros(nx,1);
    
    %Define system matrices
    A11 = [.118 -.191 .287 ; .847 .264 .943 ; -.333 .514 -.217]; %set matrices for system
    A12 = [1 2; 3 -4; -2 1];
    A21 = zeros(2,3);
    A22 = [.811 -.226;.477 .415];
    
    A = [A11 A12; A21 A22];
    E = [0 0; 0 0; 0 0; 0.193 0.689 ; -0.320 -0.749];
    C = eye(ny);
    F = eye(ny);
    
    %Disturbance and measurement noise properties
    sigma = 0.3162;
    %---------------------------------------------------------------------%
    
    
    
    %---------------------------------------------------------------------%
    %Simulate the system
    
    %Initialize the loop
    x = x0;
    %define where we introduce fault as time t
    t = 51;
    %Loop over time steps
    for k = 1:t-1
        
        %Generate random disturbance and measurement noise vectors
        % - w1 and w2 are uniform random vectors in the interval [-2,2]
        % - v1, v2, and v3 are Gaussian, zero mean, standard dev = sigma
        % - v4 and v5 are zero (no noise on these measurements)
        w = (4*(rand(2,1)-0.5));
        v = sigma*[randn(3,1); zeros(2,1)];
        
        %Compute the measured output for step k
        y = C*x + F*v;
        
        %Update the state from k to k+1
        x = A*x + E*w;
        
        %Store data to return as function output
        tData(k  ) = k ;
        yData(k,:) = y';
        
    end %End loop over time steps
    %---------------------------------------------------------------------%
%     %Simulate a fault that can be detected
%     %In this fault, the measurement noises change such that the mean shifts
%     %by 10
%     for k = t:K
%         
%         %Generate random disturbance and measurement noise vectors
%         % - w1 and w2 are uniform random vectors in the interval [-2,2]
%         % - v1, v2, and v3 are Gaussian, zero mean, standard dev = sigma
%         % - v4 and v5 are zero (no noise on these measurements)
%         w = (4*(rand(2,1)-0.5));
%         v = sigma*[randn(3,1); zeros(2,1)]+10;
%         
%         %Compute the measured output for step k
%         y = C*x + F*v;
%         
%         %Update the state from k to k+1
%         A22 = 1*A22;
%         A = [A11 A12; A21 A22];
%         x = A*x + E*w;
%         
%         %Store data to return as function output
%         tData(k  ) = k ;
%         yData(k,:) = y';
% 
%         
%     end %End loop over time steps
    
    %---------------------------------------------------------------------%
    %Simulate a fault that cannot be detected
    %In this fault, the system dynamics change such that A22=0.
    for k = t:K
        
        %Generate random disturbance and measurement noise vectors
        % - w1 and w2 are uniform random vectors in the interval [-2,2]
        % - v1, v2, and v3 are Gaussian, zero mean, standard dev = sigma
        % - v4 and v5 are zero (no noise on these measurements)
        w = (4*(rand(2,1)-0.5));
        v = sigma*[randn(3,1); zeros(2,1)];
        
        %Compute the measured output for step k
        y = C*x + F*v;
        
        %Update the state from k to k+1
        A22 = zeros(2,2);
        A = [A11 A12; A21 A22];
        x = A*x + E*w;
        
        %Store data to return as function output
        tData(k  ) = k ;
        yData(k,:) = y';

        
    end %End loop over time steps

end
