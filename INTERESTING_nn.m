function [Y,Xf,Af] = INTERESTING_nn(X,~,~)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 03-Dec-2015 20:53:54.
%
% CPELEC1 Project 
% Karlos Castillo, Aldwin del Rosario, Adrian Jarabelo
% INTegral Emergency RESponse Tool for Identifying Natural disaster Gravity
% (Typhoon Damage Cost Estimation through Artificial Neural Network) 
% 
%
%
% [Y] = myNeuralNetworkFunction(X,~,~) takes these arguments:
%
%   X = 1xTS cell, 1 inputs over TS timsteps
%   Each X{1,ts} = 4xQ matrix, input #1 at timestep ts.
%
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = 1xQ matrix, output #1 at timestep ts.
%
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1_xoffset = [35;52;17;51];
x1_step1_gain = [0.0266666666666667;0.00574712643678161;0.2;0.133333333333333];
x1_step1_ymin = -1;

% Layer 1
b1 = [2.9056856390630861;2.6333735270468539;2.5132427236670254;-2.1159854939912308;-1.9809445390043647;-1.3559708126658059;1.6558529993171316;0.81989102228678779;0.093630319410648505;0.29389495315832936;0.083105031510380303;0.62370160586795631;0.75382157429505392;0.49163347036749228;1.2887927641118264;1.8236331387021782;2.1052374832273779;-2.602149894418603;2.918778616024611;-2.8759966933407721];
IW1_1 = [-1.372939683474004 1.0375718834552765 -1.7133278674015286 1.5973717069509457;-0.62997177030486751 -1.496121544771932 1.8542257878283404 1.5848588614162928;-2.2133026331271264 -0.69202178109883083 -0.84077171742322965 1.4749042022475354;2.1407878961205906 0.63592428627496111 0.11068339112537758 1.9148445319684748;1.5043011556332015 0.022359847409799658 1.9209387533810311 1.4912516131310278;1.2190399664843825 1.3741413969247456 1.7625858204914611 -1.7096196815903373;-2.1169860606898356 0.18462998178764381 -2.2153437289257201 0.44783811728481809;-0.63303056292051518 -1.7977118348473624 1.2600771272568929 -2.0177623214476279;-1.2132642265746463 0.91006489599302987 1.8683576406100668 1.8430933902815729;-0.14948105652182875 -1.2586366958156829 2.1385622794644377 1.4530262317112206;1.6444153029501749 0.64312136839769141 -1.6034416689414102 -1.5313095894461997;0.14166521474021368 0.7177445208927371 -1.8889987027690771 2.2818867401806071;0.99785335989879087 -2.1769467682093562 1.5696647184930368 -0.51708186916155052;0.81321954147861097 -1.5908622654522993 -2.4797078118746856 -0.087756653336148169;1.0324762813740582 -1.8845656466028058 -2.0422905898781973 -0.94189233222736535;1.7185913657257474 -1.7303378199875541 0.084563725222935981 1.374796950288691;0.62347290954977808 -1.6260342147116629 1.9050763951514882 1.3331560058041241;-1.2975025476540916 1.4683124762522834 1.8165046679140018 -0.22365926215171891;0.20803432250890413 -1.4967830201942014 -2.1366990429259101 1.2927624637090018;-1.4638272921001647 1.9083695876072664 0.20900830384051949 1.8758145307887117];

% Layer 2
b2 = 1.2733278701657282;
LW2_1 = [-0.16941698357902199 -0.032162788435850166 -0.97027375324662146 0.16261974578225841 -0.011525147509176914 -0.95563223054864432 -0.638356306758045 -0.08097084219571446 -0.19618920218771155 -0.027899426171036319 -0.20670343449047382 0.13791446258835344 0.056760574207415225 -0.82516985385983899 0.98084276757123368 0.0091540250837865121 -0.027570774847435617 0.35812680877975855 -0.90513040337441242 0.37468308484727447];

% Output 1
y1_step1_ymin = -1;
y1_step1_gain = 0.000219792031548913;
y1_step1_xoffset = 0.48904;

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX, X = {X}; end;

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
    Q = size(X{1},2); % samples/series
else
    Q = 0;
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS
    
    % Input 1
    Xp1 = mapminmax_apply(X{1,ts},x1_step1_gain,x1_step1_xoffset,x1_step1_ymin);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = repmat(b2,1,Q) + LW2_1*a1;
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a2,y1_step1_gain,y1_step1_xoffset,y1_step1_ymin);
end

% Final Delay States
Xf = cell(1,0);
Af = cell(2,0);

% Format Output Arguments
if ~isCellX, Y = cell2mat(Y); end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings_gain,settings_xoffset,settings_ymin)
y = bsxfun(@minus,x,settings_xoffset);
y = bsxfun(@times,y,settings_gain);
y = bsxfun(@plus,y,settings_ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings_gain,settings_xoffset,settings_ymin)
x = bsxfun(@minus,y,settings_ymin);
x = bsxfun(@rdivide,x,settings_gain);
x = bsxfun(@plus,x,settings_xoffset);
end
