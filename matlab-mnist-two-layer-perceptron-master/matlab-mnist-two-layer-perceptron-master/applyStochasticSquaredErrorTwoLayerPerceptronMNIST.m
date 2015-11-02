function [hiddenWeights,outputWeights, error, startTime, finalTime, result] = applyStochasticSquaredErrorTwoLayerPerceptronMNIST(name,inputValuesKaggle, targetValuesKaggle )
%applyStochasticSquaredErrorTwoLayerPerceptronMNIST Train the two-layer
%perceptron using the MNIST dataset and evaluate its performance.

    % Load MNIST.
    %inputValues = loadMNISTImages('train-images.idx3-ubyte');
    
    %load('simplifiedDataBlur');
    %inputValues = inputValuesKaggle;%csvread('train.csv',1,41999,[1 41999 1 1])';
   
    %labels = targetValuesKaggle;%loadMNISTLabels('train-targetValuesKaggle.idx1-ubyte');
    %targetValuesKaggle = amostras(:,21:24);
    
    % Transform the targetValuesKaggle to correct target values.
    %targetValues = csvread('train.csv',1,1);
    %inputValues(1,:) = [];
    for n = 1: size( targetValuesKaggle , 1)
        targetValues(targetValuesKaggle(n) + 1, n) = 1;
    end;
   
    % Choose form of MLP:
    numberOfHiddenUnits = 100;
    
    % Choose appropriate parameters.
    learningRate = 0.05;
    
    % Choose activation function.
    activationFunction = @logisticSigmoid;
    dActivationFunction = @dLogisticSigmoid;
    
    % Choose batch size and epochs. Remember there are 60k input values.
    batchSize = 2000;
    epochs = 60000;
    
    fprintf('Train twolayer perceptron with %i hidden units.\n', numberOfHiddenUnits);
    fprintf('Learning rate: %d.\n', learningRate);
    
    [hiddenWeights, outputWeights, error, startTime, finalTime] = trainStochasticSquaredErrorTwoLayerPerceptron(activationFunction, dActivationFunction, numberOfHiddenUnits, inputValuesKaggle, targetValues, epochs, batchSize, learningRate, name);
    
    % Load validation set.
    %inputValues = loadMNISTImages('t10k-images.idx3-ubyte');
    %load('simplifiedTestDataBlur');
    %inputValues = csvread('test.csv',1,1);
    %inputValues = inputValuesTest;
    
    %inputValues(1,:) = [];
    %targetValuesKaggle = loadMNISTLabels('t10k-targetValuesKaggle.idx1-ubyte');
    %labels = csvread('test.csv',1,41999,[1 41999 1 1]);
    
    % Choose decision rule.
    %fprintf('Validation:\n');
    
    %[result] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues);
    
    %fprintf('Classification errors: %d\n', classificationErrors);
    %fprintf('Correctly classified: %d\n', correctlyClassified);
    
    fprintf('Start time: %d\n', startTime);
    fprintf('End time: %d\n', finalTime);
    
    fprintf('batchSize size: %d\n', batchSize);
    fprintf('epochs: %d\n', epochs);
    
    fprintf('Number units: %d\n', numberOfHiddenUnits);
    fprintf('learningRate: %d\n', learningRate);
    
    %escreve em arquivo
    fid=fopen('OutputsNN.txt','a');
    %fprintf(fid, [ 'name;',' classificationErrors;', ' correctlyClassified;', ' batchSize;' ,' epochs;', ' numberOfHiddenUnits;', ' learningRate;', ' startTime;' ,' finalTime;', '\n']);
%    fprintf(fid, '%s; %d; %d; %d; %d; %d; %d; %s; %s \n', name,classificationErrors ,correctlyClassified , batchSize ,epochs, numberOfHiddenUnits, learningRate, strtrim(num2str(startTime)), strtrim(num2str(finalTime)));
    fclose(fid);
end