%-------------------------------------------------------------------------%
% Function: P1_main
%
% Description: Main function for Problem 1.
%
% Inputs: None
%
% Outputs: None
%-------------------------------------------------------------------------%

function P1_main

    %---------------------------------------------------------------------%
    %Generate some random data
    nVar  = 2;
    nData = 500;
    Data = [1 -1; -0.3 1]*randn(nVar,nData);
    
    %Plot the data
    figure
    hold on;
    scatter(Data(1,:),Data(2,:));
    title('Original Data')
    xlabel('y_1');
    ylabel('y_2');
    %---------------------------------------------------------------------%

end