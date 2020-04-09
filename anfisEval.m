function [outputArg1, outputArg2, outputArg3, outputArg4] = anfisEval(trainData, validationData, testData, genfisObject)
%ANFISEVAL Summary of this function goes here
%   Detailed explanation goes here



        anfisOpt = anfisOptions('InitialFIS',genfisObject);
        anfisOpt.DisplayANFISInformation = 0;
        anfisOpt.DisplayErrorValues = 0;
        anfisOpt.DisplayStepSize = 0;
        anfisOpt.DisplayFinalResults = 0;
        anfisOpt.ValidationData = validationData;

        %  [fis,trainError,stepSize,chkFIS,chkError] = anfis(trainingData,options)

        fprintf('-->%s\n','Start training first ANFIS network.')
        %outFIS = anfis(trndata1(:,1:4), anfisOpt);

        [outFis,trainError,stepSize, chkFIS, chkError] = anfis(trainData(:,1:4), anfisOpt);
        
        trnOut1 = evalfis(outFis, trainData(:,1:3) );
        chkOut  = evalfis(chkFIS, testData(:,1:3) );   
        
        thetaDifference = testData(:,4) - chkOut;

        

        
outputArg1 =  thetaDifference;
outputArg2 = 2;
outputArg3 = 3;
outputArg4 = 4;

end

