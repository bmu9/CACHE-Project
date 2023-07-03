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
    
    
    
    %---------------------------------------------------------------------%
    %P1.1
    Y0 = Data';
    MeanMat = ones(nData,1)*mean(Y0);
    StdMat = ones(nData,1)*std(Y0);
    Y = (Y0-MeanMat)./StdMat;
    % Y can also be directly computed using Matlab "normalize" function
    
    figure
    hold on;
    scatter(Y(:,1),Y(:,2));
    xlabel('y_1');
    ylabel('y_2');
    
    
    %P1.2
    S = 1/(nData-1)*Y'*Y;% Can also use "cov" function
    [V,D] = eig(S);
    fprintf('Two eigenvalues are %.4f and %.4f.\n',D(1,1),D(2,2))
    % Since the larger eigenvalue is greater than 10 times of the smaller one, 
    % we can only keep one of them.
    
    
    %P1.3
    %Plot the first eigenvector
    plot([V(1,1),-V(1,1)],[V(2,1),-V(2,1)],'k','LineWidth',2) %Multiply a factor 3 to elongate the line
    
    %Plot the first eigenvector
    plot(3*[V(1,2),-V(1,2)],3*[V(2,2),-V(2,2)],'r','LineWidth',2)
    
    xlim([-3,3])
    ylim([-3,3])
    width=500;
    height=500;
    set(gcf,'position',[0,0,width,height])
    
    % The data points spreads along the eigenvector corresponding with the
    % greater eigenvalue, and accumulates along the eigenvector
    % corresponding with the smaller eigenvalue


    S
    V
    D
    
    
    
    %---------------------------------------------------------------------%

end