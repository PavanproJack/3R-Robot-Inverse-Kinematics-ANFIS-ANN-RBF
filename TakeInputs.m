clc, clear 

l1 = 10; % length of first arm
l2 = 7; % length of second arm
l3 = 5; % length of third arm
%%traning data
theta1 = rand(1,12)*90; % all possible theta1 values
theta2 = rand(1,12)*90; % all possible theta2 values
theta3 = rand(1,12)*90; % all possible theta3 values
% generate a grid of theta1 and theta2 and theta3 values
[THETA1, THETA2,THETA3] = ndgrid(theta1, theta2, theta3); 
% compute x coordinates
X = l1 * cos(THETA1*pi/180) + l2 * cos(THETA1*pi/180 + THETA2*pi/180) + l3*cos(THETA1*pi/180+THETA2*pi/180+THETA3*pi/180); 
  % compute y coordinates
Y = l1 * sin(THETA1*pi/180) + l2 * sin(THETA1*pi/180 + THETA2*pi/180) + l3*sin(THETA1*pi/180+THETA2*pi/180+THETA3*pi/180);
phi = THETA1 + THETA2 + THETA3;
% create training dataset
data = [X(:) Y(:) phi(:) THETA1(:) THETA2(:) THETA3(:)]; 

data_ = data(  randperm( size(data, 1) ),   :  );

trndata1=data_(1:round( size(data_,1)*5/7),1:4); %21600*4
chkdata1=data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),1:4);
tesdata1=data_(round(size(data_,1)*6/7)+1:size(data_,1),1:4);

clusteringType = input('Input the type of clustering :   ');

switch clusteringType
      case 1  % GridPartition
          
          disp("Selected Clustering type : Grid Partition");
          
            genfisOpt_1 = genfisOptions('GridPartition');
            genfisOpt_1.NumMembershipFunctions = [4 4 4];
            genfisOpt_1.InputMembershipFunctionType = ["trimf" "gaussmf", "gaussmf"];
            genfisObject_1=genfis(trndata1(:, 1:3),trndata1(:, 4), genfisOpt_1);
            
            %{ 
                genfisOpt_2 = genfisOptions('GridPartition');
                genfisOpt_2.NumMembershipFunctions = [4 4 4];
                genfisOpt_2.InputMembershipFunctionType = ["trimf" "gaussmf", "gaussmf"];
                genfisObject_2=genfis(trndata1(:, 1:3),trndata1(:, 4), genfisOpt_2);

                genfisOpt_3 = genfisOptions('GridPartition');
                genfisOpt_3.NumMembershipFunctions = [4 4 4];
                genfisOpt_3.InputMembershipFunctionType = ["trimf" "gaussmf", "gaussmf"];
                genfisObject_3=genfis(trndata1(:, 1:3),trndata1(:, 4), genfisOpt_3);
            %}
            
            
            
            [a, b, c, d] = anfisEval(trndata1, chkdata1, tesdata1, genfisObject_1);
            disp(a);
            
            
            %{
                [x,mf] = plotmf(genfisObject, 'input',1);
                subplot(3, 1, 1);
                plot(x,mf)
                xlabel('Membership Functions for Input 1')

                [x,mf] = plotmf(genfisObject, 'input',2);
                subplot(3, 1, 2);
                plot(x,mf)
                xlabel('Membership Functions for Input 2')

                [x,mf] = plotmf(genfisObject, 'input',3);
                subplot(3, 1, 3);
                plot(x,mf)
                xlabel('Membership Functions for Input 3')
                %}
            
      case 2  % FCM Clustering
          
            genfisOpt = genfisOptions('FCMClustering' );
            genfisObject=genfis(trndata1(:, 1:3),trndata1(:, 4), genfisOpt);
            
      case 3  % Subtractive Clustering
          
            genfisOpt = genfisOptions('SubtractiveClustering', 'ClusterInfluenceRange',[0.5 0.25 0.3 0.4]); 
            genfisObject=genfis(trndata1(:, 1:3),trndata1(:, 4), genfisOpt);
            
    otherwise 
            disp('Something went wrong')
end


%{
figure()
subplot(3,1,1);
plot(theta1_diff);
ylabel('theta1 error')
title('Desired theta1 - Predicted theta1(degree)')
%}










