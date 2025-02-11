function [outputClassification] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues)
% validateTwoLayerPerceptron Validate the twolayer perceptron using the
% validation set.
%
% INPUT:
% activationFunction             : Activation function used in both layers.
% hiddenWeights                  : Weights of the hidden layer.
% outputWeights                  : Weights of the output layer.
% inputValues                    : Input values for training (784 x 10000).
% labels                         : Labels for validation (1 x 10000).
%
% OUTPUT:
% correctlyClassified            : Number of correctly classified values.
% classificationErrors           : Number of classification errors.
% 

    testSetSize = size(inputValues, 2);
    classificationErrors = 0;
    outputClassification(1:28000,2) = 0;
    
    for n = 1: testSetSize
        inputVector = inputValues(:, n);
        outputVector = evaluateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputVector);
        
        class = decisionRule(outputVector);
        outputClassification(n,2)= class-1;
        outputClassification(n,1)= n;
    end;
end

function class = decisionRule(outputVector)
% decisionRule Model based decision rule.
%
% INPUT:
% outputVector      : Output vector of the network.
%
% OUTPUT:
% class             : Class the vector is assigned to.
%

    max = 0;
    class = 1;
    for i = 1: size(outputVector, 1)
        if outputVector(i) > max
            max = outputVector(i);
            class = i;
        end;
    end;
end

function outputVector = evaluateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputVector)
% evaluateTwoLayerPerceptron Evaluate two-layer perceptron given by the
% weights using the given activation function.
%
% INPUT:
% activationFunction             : Activation function used in both layers.
% hiddenWeights                  : Weights of hidden layer.
% outputWeights                  : Weights for output layer.
% inputVector                    : Input vector to evaluate.
%
% OUTPUT:
% outputVector                   : Output of the perceptron.
% 

    outputVector = activationFunction(outputWeights*activationFunction(hiddenWeights*inputVector));
end