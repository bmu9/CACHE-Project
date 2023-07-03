%-------------------------------------------------------------------------%
% Function: getT2(y,Vbar,Dbar)
%
% Description: Computes the T2 value for the scaled measurement y for PCA
% fault detection.
%
% Inputs: y    - ny-dim scaled measured output vector
%         Vbar - ny-by-p principal direction matrix obtained from PCA 
%                analysis of historical data. The p columns of Vbar are the
%                p retained eigenvectors.
%         Dbar - p-by-p diagonal eigenvalue matrix obtained from PCA
%                analysis of historical data. The p diagonal entries are
%                the p retained eigenvalues.
%
% Outputs: T2 - the scalar T2 value
%-------------------------------------------------------------------------%

function T2 = getT2(y,Vbar,Dbar)

    %---------------------------------------------------------------------%
    %Calculate the T2 value
    
    %---------------------------------------------------------------------%
    
end