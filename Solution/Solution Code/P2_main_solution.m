%-------------------------------------------------------------------------%
% Function: P2_main
%
% Description: Main function for Problem 2. All other functions should
% be called from here, not run independently. Students will modify and add
% to several parts of this file as described in the comments. As
% distributed, running this code should produce a plot the outputs of the
% simulated fault-free system, and a second plot containing dummy values of
% the T2 statistic for PCA fault detection.
%
% Inputs: None
%
% Outputs: None
%-------------------------------------------------------------------------%

function P2_main

    %---------------------------------------------------------------------%
    %Do offline PCA calculations
    
    %Load historical data from csv file
    histData = readmatrix('historicalData.csv');

    %Students complete the rest of this section to compute Vbar and
    %Dbar. Read the header comments for the function getT2.m for
    %definitions of these variables.

    %Scale and center data so all variables are zero mean and standard deviation one
    [nVars,nData] = size(histData);
    mu    = mean(histData,   2); 
    sigma = std (histData,[],2); 
    scaleMat = inv(diag(sigma)); 
    X  = scaleMat*(histData - mu*ones(1,nData));

    %performing PCA
    C = cov(X'); 
    [V,D] = eigs(C);
    
    %last eigenvalue is very small
    p = 4;
    Vbar = V(:,1:p);
    Dbar = D(1:p,1:p);
    %---------------------------------------------------------------------%
    
    
    
    %---------------------------------------------------------------------%
    %Do online PCA calculations
    
    %Simulate the system
    % - The following code collects the output data for the entire time
    %   horizon. In reality we would execute the online detection test for
    %   each new measurement as soon as it arrives, but that complicates
    %   the code too much.
    [tData,yData] = simulateProcess;

    %Use these lines in place of the one above to show solutions to Problem
    %2 Parts 3-5.

    %[tData,yData] = simulateProcessP2part3solution;
    %[tData,yData] = simulateProcessP2part4solution;
    %[tData,yData] = simulateProcessP2part5solution;

    [K,ny] = size(yData);
    
    %Plot outputs vs. time
    PLOT_SIM_RESULTS = 1; %<-- Set to 0 to easily suppress the plot
    if PLOT_SIM_RESULTS
        figure;
        hold on;
        for i=1:ny
            plot(tData,yData(:,i));
        end
        xlabel('time (s)')
        ylabel('Outputs')
        legend('y1','y2','y3','y4','y5')
    end
    
    %Loop over time steps to do online fault detection test
    for k = 1:K
        
        %Get the kth measurement
        y = yData(k,:)';
        
        %Scale the measurement using the same means and standard deviations
        %used to scale the historical data
        % - Students uncomment and complete this line
        yscaled = scaleMat*(y - mu); 
        
        %Compute T2 for the measurement
        % - The next line of code will not run until you complete the
        %   code in the provided function template getT2.m.
        % - You will also need to implement the offline PCA calculations in
        %   the section above and define the variables Vbar and Dbar
        % - Read the header comments for the function getT2.m for a precise
        %   statement of what these variables have to contain.
        
        T2(k) = getT2solution(yscaled,Vbar,Dbar);
        
        %This is a dummy value so the code runs. Delete it once the line
        %above is working
        %T2(k) = 0.5;

    end
    
    %Plot T2 and threshold vs. time
    PLOT_T2_RESULTS = 1; %<-- Set to 0 to easily suppress the plot
    if PLOT_T2_RESULTS
        
        %Compute the threshold
        n = 0.95; %sets confidence level
        m = K   ; %number of data points
        thresh = ((p*(m-1)*(m+1))/(m*(m-p)))*finv(n,p,m-p);
        
        figure;
        hold on;
        plot(tData,T2);
        plot(tData,thresh*ones(K,1))
        xlabel('time (s)')
        ylabel('T2')
        legend('T2','Threshold')
    end
    
    %---------------------------------------------------------------------%
    
end