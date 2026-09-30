clc;
clear;
close all;

%% ============================================================
% GENETIC ALGORITHM
% Queueing Model Cost Optimization
%
% FIGURE:
%   Blue shaded area = Population Min-Max Range
%   Green line       = Mean Fitness
%   Red line         = Current Generation Best Fitness
%
% IMPORTANT:
% Red line is NOT the overall best-so-far.
% Red line shows the best individual in EACH generation.
%
% Actual fitness values are never modified.
% ============================================================


%% ============================================================
% GA PARAMETERS
% ============================================================

nVars = 4;                     
lb = [0 0 0 0];            
ub = [4 3.5 2 2];

popSize = 10;
maxGen  = 300;

pc = 0.80;
pm = 0.10;


%% ============================================================
% FIXED Y-AXIS
% ============================================================

yFixedMin = 150;
yFixedMax = 250;


%% ============================================================
% RANDOM NUMBER GENERATOR
% ============================================================

rng default;


%% ============================================================
% INITIALIZE POPULATION
% ============================================================

pop = zeros(popSize,nVars);
fitness = zeros(popSize,1);

count = 0;
attempts = 0;
maxAttempts = 10000;


while count < popSize && attempts < maxAttempts

    candidate = lb + rand(1,nVars).*(ub-lb);

    [c,ceq] = constraints_function(candidate);

    feasible = all(c <= 0);

    if ~isempty(ceq)
        feasible = feasible && all(abs(ceq) <= 1e-8);
    end

    if feasible

        count = count + 1;

        pop(count,:) = candidate;

        fitness(count) = ...
            objective_function(candidate);

    end

    attempts = attempts + 1;

end


%% ============================================================
% CHECK INITIAL POPULATION
% ============================================================

if count < popSize

    error(['Could not generate a complete feasible ', ...
           'initial population. Check your ', ...
           'constraints_function.m and bounds.']);

end


%% ============================================================
% HISTORY
% ============================================================

meanFitnessHist       = zeros(maxGen,1);
minFitnessHist        = zeros(maxGen,1);
maxFitnessHist        = zeros(maxGen,1);

% THIS IS THE RED CURVE
currentBestFitnessHist = zeros(maxGen,1);

% Overall best is stored separately
overallBestFitnessHist = zeros(maxGen,1);

bestSolutionHist = zeros(maxGen,nVars);


%% ============================================================
% OVERALL BEST
% ============================================================

overallBestFitness = inf;
overallBestSolution = zeros(1,nVars);


%% ============================================================
% CREATE FIGURE
% ============================================================

figure(1);

set(gcf,...
    'Position',[100 100 900 600],...
    'Color','w');


%% ============================================================
% MAIN GA LOOP
% ============================================================

for gen = 1:maxGen


    %% ========================================================
    % 1. EVALUATE FITNESS
    %% ========================================================

    for i = 1:popSize

        fitness(i) = ...
            objective_function(pop(i,:));

    end


    %% ========================================================
    % 2. POPULATION STATISTICS
    %% ========================================================

    minFitness = min(fitness);
    maxFitness = max(fitness);
    meanFitness = mean(fitness);


    %% ========================================================
    % 3. CURRENT GENERATION BEST
    %
    % THIS VALUE IS USED FOR THE RED CURVE
    %% ========================================================

    [currentBestFitness,bestIndex] = min(fitness);

    currentBestSolution = pop(bestIndex,:);


    %% ========================================================
    % 4. STORE STATISTICS
    %% ========================================================

    minFitnessHist(gen) = minFitness;

    maxFitnessHist(gen) = maxFitness;

    meanFitnessHist(gen) = meanFitness;

    % RED CURVE
    currentBestFitnessHist(gen) = ...
        currentBestFitness;


    %% ========================================================
    % 5. UPDATE OVERALL BEST
    %% ========================================================

    if currentBestFitness < overallBestFitness

        overallBestFitness = ...
            currentBestFitness;

        overallBestSolution = ...
            currentBestSolution;

    end


    overallBestFitnessHist(gen) = ...
        overallBestFitness;

    bestSolutionHist(gen,:) = ...
        overallBestSolution;


    %% ========================================================
    % 6. DISPLAY RESULTS
    %% ========================================================

    fprintf(['Generation %3d | ',...
             'Current Best = %10.4f | ',...
             'Mean = %10.4f | ',...
             'Min = %10.4f | ',...
             'Max = %10.4f | ',...
             'Overall Best = %10.4f\n'],...
             gen,...
             currentBestFitness,...
             meanFitness,...
             minFitness,...
             maxFitness,...
             overallBestFitness);


    %% ========================================================
    % 7. PLOT
    %% ========================================================

    figure(1);

    cla;

    hold on;


    % Generation vector
    G = 1:gen;


    %% ========================================================
    % DATA TO PLOT
    %% ========================================================

    meanData = ...
        meanFitnessHist(1:gen);

    currentBestData = ...
        currentBestFitnessHist(1:gen);

    minData = ...
        minFitnessHist(1:gen);

    maxData = ...
        maxFitnessHist(1:gen);


    %% ========================================================
    % POPULATION RANGE
    %
    % IMPORTANT:
    % Do NOT change actual fitness values.
    %
    % Only the portion outside the visible axis is hidden
    % automatically by MATLAB.
    %% ========================================================

    fillX = [G fliplr(G)];

    fillY = [minData' fliplr(maxData')];


    fill(fillX,...
         fillY,...
         [0.20 0.40 0.75],...
         'FaceAlpha',0.20,...
         'EdgeColor','none',...
         'DisplayName','Population range');


    %% ========================================================
    % MEAN FITNESS
    %% ========================================================

    plot(G,...
         meanData,...
         'LineStyle','-',...
         'Color',[0.00 0.50 0.20],...
         'LineWidth',1.5,...
         'DisplayName','Mean Fitness');


    %% ========================================================
    % CURRENT GENERATION BEST
    %
    % RED CURVE
    %% ========================================================

    plot(G,...
         currentBestData,...
         'LineStyle','-',...
         'Color',[0.80 0.10 0.10],...
         'LineWidth',1.8,...
         'DisplayName','Current Generation Best');


    %% ========================================================
    % AXES
    %% ========================================================

    xlim([1 maxGen]);

    ylim([yFixedMin yFixedMax]);


    %% ========================================================
    % LABELS
    %% ========================================================

    xlabel('Generation',...
           'FontSize',12);

    ylabel('Fitness',...
           'FontSize',12);


    %% ========================================================
    % TITLE
    %% ========================================================

    title('GA Fitness Convergence',...
          'FontSize',13,...
          'FontWeight','normal');


    %% ========================================================
    % LEGEND
    %% ========================================================

    legend('Location','best',...
           'Box','off',...
           'FontSize',10);


    %% ========================================================
    % GRID
    %% ========================================================

    grid on;
    box on;


    %% ========================================================
    % AXES APPEARANCE
    %% ========================================================

    set(gca,...
        'FontSize',11,...
        'LineWidth',0.8);


    %% ========================================================
    % UPDATE
    %% ========================================================

    drawnow;


    %% ========================================================
    % 8. CREATE NEW POPULATION
    %% ========================================================

    newPop = zeros(size(pop));


    %% ========================================================
    % 9. SELECTION + CROSSOVER + MUTATION
    %% ========================================================

    for i = 1:2:popSize


        %% -----------------------------------------------------
        % TOURNAMENT SELECTION
        %% -----------------------------------------------------

        parent1 = ...
            tournament_selection(pop,fitness);

        parent2 = ...
            tournament_selection(pop,fitness);


        %% -----------------------------------------------------
        % CROSSOVER
        %% -----------------------------------------------------

        if rand < pc

            [child1,child2] = ...
                uniform_crossover_feasible(...
                parent1,...
                parent2,...
                lb,...
                ub);

        else

            child1 = parent1;
            child2 = parent2;

        end


        %% -----------------------------------------------------
        % MUTATION
        %% -----------------------------------------------------

        child1 = ...
            mutate_feasible(...
            child1,...
            lb,...
            ub,...
            pm);

        child2 = ...
            mutate_feasible(...
            child2,...
            lb,...
            ub,...
            pm);


        %% -----------------------------------------------------
        % STORE CHILDREN
        %% -----------------------------------------------------

        newPop(i,:) = child1;

        if i+1 <= popSize

            newPop(i+1,:) = child2;

        end

    end


    %% ========================================================
    % 10. REPLACE POPULATION
    %% ========================================================

    pop = newPop;

end


%% ============================================================
% FINAL RESULTS
% ============================================================

fprintf('\n');
fprintf('============================================================\n');
fprintf('                 FINAL GA RESULTS\n');
fprintf('============================================================\n');

fprintf('\nOverall Best Solution:\n');
disp(overallBestSolution);

fprintf('Overall Best Objective Value:\n');
fprintf('%.10f\n',overallBestFitness);


%% ============================================================
% FINAL CONSTRAINT CHECK
% ============================================================

[c,ceq] = ...
    constraints_function(overallBestSolution);


fprintf('\nConstraint values at overall best solution:\n');
disp(c);


if ~isempty(ceq)

    fprintf('Equality constraint values:\n');
    disp(ceq);

end


fprintf('\n');
fprintf('============================================================\n');
fprintf('GA optimization completed.\n');
fprintf('============================================================\n');


%% ============================================================
% OPTIONAL:
% SHOW FINAL CURRENT GENERATION BEST
% ============================================================

fprintf('\nFinal generation best fitness = %.10f\n',...
        currentBestFitnessHist(end));

fprintf('Overall best fitness          = %.10f\n',...
        overallBestFitness);


%% ============================================================
% HELPER FUNCTION 1
% TOURNAMENT SELECTION
% ============================================================

function selected = ...
    tournament_selection(pop,fitness)

    k = 3;

    idx = randperm(size(pop,1),k);

    [~,bestIdx] = min(fitness(idx));

    selected = pop(idx(bestIdx),:);

end


%% ============================================================
% HELPER FUNCTION 2
% UNIFORM CROSSOVER
% ============================================================

function [c1,c2] = ...
    uniform_crossover_feasible(p1,p2,lb,ub)

    mask = rand(size(p1)) > 0.5;

    c1 = p1;
    c2 = p2;

    c1(mask) = p2(mask);
    c2(mask) = p1(mask);

    c1 = repair_feasible(c1,lb,ub);

    c2 = repair_feasible(c2,lb,ub);

end


%% ============================================================
% HELPER FUNCTION 3
% MUTATION
% ============================================================

function child = ...
    mutate_feasible(child,lb,ub,pm)

    for j = 1:length(child)

        if rand < pm

            child(j) = ...
                lb(j) + ...
                rand*(ub(j)-lb(j));

        end

    end

    child = repair_feasible(child,lb,ub);

end


%% ============================================================
% HELPER FUNCTION 4
% FEASIBILITY REPAIR
% ============================================================

function x = ...
    repair_feasible(x,lb,ub)


    %% ---------------------------------------------------------
    % Keep within bounds
    %% ---------------------------------------------------------

    x = max(min(x,ub),lb);


    %% ---------------------------------------------------------
    % Check feasibility
    %% ---------------------------------------------------------

    [c,ceq] = ...
        constraints_function(x);


    feasible = all(c <= 0);

    if ~isempty(ceq)

        feasible = ...
            feasible && ...
            all(abs(ceq) <= 1e-8);

    end


    %% ---------------------------------------------------------
    % If feasible, return immediately
    %% ---------------------------------------------------------

    if feasible

        return;

    end


    %% ---------------------------------------------------------
    % Generate a new feasible point
    %% ---------------------------------------------------------

    maxAttempts = 1000;

    for attempt = 1:maxAttempts

        x = lb + ...
            rand(1,length(x)).*(ub-lb);


        [c,ceq] = ...
            constraints_function(x);


        feasible = all(c <= 0);

        if ~isempty(ceq)

            feasible = ...
                feasible && ...
                all(abs(ceq) <= 1e-8);

        end


        if feasible

            return;

        end

    end


    %% ---------------------------------------------------------
    % Error if repair failed
    %% ---------------------------------------------------------

    error('Could not repair to a feasible solution.');

end