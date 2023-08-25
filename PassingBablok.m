function [fh, stats] = PassingBablok (x,y,x_label,y_label,ShowFigure,fh,ah)
%% Passing Bablok regression 
% Perform a Passing Bablok non parametric regression.
% INPUT: x and y  are arrays in column of values obtained measuring 
%        the same sample with 2 different analytical methods. It means
%        that if you have i.e. i = 1....N samples, x (i) is the value obtained
%        measuring the sample (i) with the method A and y (i) is the value obtained 
%        measuring the same sample (i) with the method B.
% OUTPUT: 
% 1) Slope of the regression line
% 2) 95% CI of the slope
% 3) intercept of the regression line
% 4) 95% CI of the intercept
% This function also perform a statistical test of linearity and return
% the p value, using the cumsum adapted method (Kolgomogorv-Smirnov adapted
% test) described by Passing and Bablok.
% Three Graphs are plotted:
%   a. Regression Graph, scatter plot with regression line
%   b. Ranked residual Graph
%   c. cumsum statistic
% ------
% Written in July 2009 by Andrea Padoan, PADOVA, ITALY

% Copyright (c) 2009, ANDREA PADOAN, PADOVA, ITALY
% All rights reserved.
% Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions are met:
%    * Redistributions of source code must retain the above copyright
%      notice, this list of conditions and the following disclaimer.
%    * Redistributions in binary form must reproduce the above copyright
%      notice, this list of conditions and the following disclaimer in the
%      documentation and/or other materials provided with the distribution.

%THIS SOFTWARE IS PROVIDED BY ANDREA PADOAN ''AS IS'' AND ANY
%EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%DISCLAIMED. IN NO EVENT SHALL ANDRE PADOAN BE LIABLE FOR ANY
%DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
%ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  
    
%     display ( ' ' );
%     display ('Passing Bablok regression for Matlab.');
%     display ('A new Biometrical Procedure for Testing the Equality of Measurements');
%     display ('from two Different analytical methods. J. Clin. Chem. Clin. Biochem.');
%     display ('Vol 21, 1983, pp 709-720');
%     display ('H. Passing, W. Bablok');
%     display ('Written in July 2009 by Andrea Padoan, PADOVA, ITALY');
%     display(' ');

%% Find missing values and drop them
    % Find NaN and drop them
    
    %Calculate the number of measurements (n)
    n = length (x);
    
    i= 1;
    n_dropped = 0;
    
    while i <= n
        if isnan(x(i)) == 1 
            x(i) = [];
            y(i) = [];
            n_dropped = n_dropped + 1;
            n = n - 1;
        elseif isnan(y(i)) == 1
            x(i) = [];
            y(i) = [];
            n_dropped = n_dropped + 1;
            n = n - 1;
        end
        i = i  + 1;
    end
    if n_dropped > 0
        display ('Warning: found some NaNs');
        display ('Number of dropped values : ');
        display (n_dropped);
    end
    
%% Estimation of beta and alpha, according to Theil regression. 

    %Recalculate the number of measurements (n). Some rows can be dropped.
    n = length (x);
    
    % Calculate all combinations of the n elements in y taken 2 at a time and
    % put its into an array
    yij = combnk(y, 2);

    yi = yij (:,1);
    yj = yij (:,2);


    % Calculate all combinations of the n elements in x taken 2 at a time and
    % put its into an array
    xij = combnk(x, 2);

    xi = xij(:,1);
    xj = xij(:,2);

    % Get number of combination array elements  
    ncomb = length (xi);

    %N rappresent the number of combination without identical pairs of
    %measurements and without cases with S = -1
    N = 1;

    %Calculate Sij = (yi-yj)/(xi-xj)
    for nindex = 1:1:ncomb
        %First rule: identical pairs of measurements with xi=xj and yi=yj do not
        %contribute to estimation of beta
        if ( (yi(nindex)~= yj (nindex)) || (xi (nindex) ~= xj (nindex)) )
            Sij (N)= (yi(nindex)-yj(nindex))/(xi(nindex)-xj(nindex));
            %Second rule: any Sij with a value of -1 is disregarded.
            if Sij (N) ~= -1
                N = N+1;
            end
        end
    end
    %Adjust N
    N = N - 1;

    %Sort Sij for obtain the ranked sequence
    S=sort(Sij, 'ascend');
    %Calculate K , that is the number of values of Sij with Sij < -1
    K = 0;

    %Count K, the number of values of Sij < -1
    for nindex =1:1:N
        if (S(nindex) < -1)
            K = K +1;
        end
    end

    %Estimates b using K as an offset. b is estimated by the shifted median b
    %of the Si using K as offset.

    %If N is odd
    if rem(N, 2) ~= 0
        b = S ( (N+1)/2+K );
    else %if N is even
        b = 0.5 * ( S (N/2+K) + S (N/2+1+K) );
    end

    stats.Slope = b;
    

%% Estimate slope and intercept 95 % confidence intervals

    %Define a quantile for the costruction of two side confidence interval for
    %beta. 1.96 means 95 % CI

    w = 1.96;
    C= w * sqrt ( (n*(n-1)*(2*n+5) ) /18 ) ;
    M1 = (N - C)/2;
    M1 = round(M1);
    M2 = N-M1+1;

    %Slope confidence intervals
    stats.slope_UB = S(M2+K);
    stats.slope_LB = S(M1+K);

    %Estimation of alpha (=a) and alpha confidence's intervals
    a = median (y-x*b);
    stats.Intercept = a;
    stats.a_LB = median (y-stats.slope_UB*x);
   stats. a_UB = median (y-stats.slope_LB*x);

%% Statistical test of the assumption of linearity

    %Calculare for every (xi,yi) point the distance from the intercept. These 
    %D values are needed for rank (xi,yi)

    for i =1:1:n
        D (i) = ( y(i)+(1/b)*x(i)-a )/ sqrt (1+1/(b*b));
    end

    %Create an array with D in the first row, x in the second and y in the
    %third.

    Dxy = D';
    Dxy (:,2) = x;
    Dxy (:,3) = y;

    %Sort the first column of the array. In this way you rank xy for the
    %distance from the intercept.
    Dxy = sortrows (Dxy, 1);

    %Create a new variable with ranked xy
    ranked_xy = Dxy (:,2:3);

    %Dxy (:,4)=a+b*Dxy(:,2);

    %Calculate the number of l and L. l denote the number of points (xi, yi)
    %with yi > a+bxi and L the number of point with yi < a+bxi.
    l = 0;
    L = 0;
   
    for i =1:1:n
       if y (i) > a+b*x(i)
           l = l + 1;
       elseif y (i) < a+b*x(i)
           L = L + 1;
       end
    end

   
    %Give a score r to each point of ranked xy. This rules are specified on
    %Passing Bablok paper (1985). r now is ranked, like ranked_xy.
    for i = 1:1:n
       if ranked_xy(i,2) > a+b*ranked_xy(i,1)
           r (i) = sqrt(L/l);
       elseif ranked_xy(i,2) < a+b*ranked_xy(i,1)
           r (i) = - sqrt(l/L);
       elseif ranked_xy(i,2) == a+b*ranked_xy(i,1)
           r (i) = 0;
       end
    end   
    
    %Calculate cumulative sum of ranked r.
    cumsum_r = cumsum (r);
    %Calculate max absolute value of cumsum of r.
    stats.max_cumsum_r = max(abs (cumsum_r));

%% Display results of statistic test.

    %Calculates limits using critical values of Kolmogorov-Smirnov test.
    p1perc = 1.63*sqrt(L+l)
    p5perc = 1.36*sqrt(L+l)
    p10perc = 1.22*sqrt(L+l)

    display('Test for linear assumption: ');
    display('         H0: x and y are linear relationship');
    display( ' ');

    if stats.max_cumsum_r <= p10perc 
        results_str =  {'p > 0.1, x and y have a linear relationship';'Do not reject H0'};
        %crt_value = p10perc
    end

    if (stats.max_cumsum_r >= p10perc) && (max_cumsum_r < p5perc)
        results_str =  {'p > 0.05, x and y have a linear relationship';'Do not reject H0'};
        %crt_value = p10perc
        %crt_value = p5perc
    end

    if (stats.max_cumsum_r >= p5perc) && (max_cumsum_r <= p1perc)
        results_str =   {'0.01 < p < 0.05 Linear relationship between x and y is rejected'};
        %crt_value = p5perc
        %crt_value = p1perc
    end

    if (stats.max_cumsum_r >= p1perc)
        results_str =   {'p < 0.01 Linear relationship between x and y is rejected'};
        %crt_value = p1perc
    end

%% Plot regression graph

    %Plot point of (xi,yi)
    %figure ('Name', 'Passing Bablok Regression fit', 'NumberTitle','off');
    % fh = figure('Name','Passing Bablok Regression fit', 'NumberTitle','off','Color','w','Tag','Gene Sample Plot','Visible',ShowFigure,'Units','inches');
    % fh.Position(3) = 5;
    % fh.Position(4) = 5;
    % ah = axes(fh,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',10,'Linewidth',0.5,...
    % 'ActivePositionProperty','outerposition','XGrid','on','YGrid','on');
    % axis equal

min_xy = min([x;y]);
max_xy = max([x;y]);
NudgeVal = (max_xy - min_xy) / 25;
% ax.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
% ah.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
% ah.XTick=[ceil(min_xy-NudgeVal):floor(max_xy+NudgeVal)];
% ah.YTick=[ceil(min_xy-NudgeVal):floor(max_xy+NudgeVal)];

    %scatter(ah,x,y,50,'k','LineWidth',1.5);
    line(x,y,'Parent',ah,'LineStyle','none','Marker','o','MarkerEdgeColor',[0 0 0],'Color','k','MarkerFaceColor','none','MarkerSize',12);
    line ([min_xy max_xy], [ min_xy max_xy],'Parent',ah, 'Color', 'r', 'LineStyle', '-.' , 'LineWidth', 1.5);
    hold on;
 
    %Fit the curve from lowest value of x to the largest.
    xhat = sort(x);
    for i = 1:1:n
        yhat(i) = a+b*xhat(i);
    end
    %Create a curve for slope_UB (upper 95 %CI) and slope_LB(lower 95 %CI)
    for i = 1:1:n
        yhatLB(i) = stats.a_LB+stats.slope_LB*xhat(i);
        yhatUB(i) = stats.a_UB+stats.slope_UB*xhat(i);
    end
        
    %Define max values for axis
%     if max(sort(x)) > max(sort(y))
%         axis ([0 max(x) 0 max(x)]);
%     else
%         axis ([0 max(y) 0 max(y)]);
%     end
    %Plot the line
    plot (xhat, yhat, 'LineWidth', 2, 'Color', 'b');
    %plot (xhat, yhatLB, 'LineWidth', 1, 'Color', 'black', 'LineStyle','--','LineWidth',1.5);
    %plot (xhat, yhatUB, 'LineWidth', 1, 'Color', 'black', 'LineStyle','--','LineWidth',1.5);
    %title ({'Passing-Bablok regression fit';results_str}, 'FontSize',12, 'Color', 'k', 'fontweight','normal');
    title (results_str, 'FontSize',10, 'Color', 'k', 'fontweight','normal');
    xlabel (x_label);
    ylabel (y_label);

%     if max(xhat) >= max(yhat) 
%         line ([ min(xhat) max(xhat)], [ min(xhat) max(xhat)], 'Color', 'r', 'LineStyle', '-.' , 'LineWidth', 1.5);
%     else
%         line ([0 max(yhat)], [0 max(yhat)], 'Color', 'r', 'LineStyle', '--' , 'LineWidth', 1.5);
%     end
%    legend(ah,{sprintf('Sample n=%u',length(x))','identity',sprintf('%.2g + %.3g * Method1',a,b),'LB slope','UB slope'},'Location','northwest','FontSize',7,'FontWeight','normal')


    legend(ah,{sprintf('Sample n=%u',length(x))','identity',sprintf('%.2g + %.3g * Method1',a,b)},'Location','northwest','FontSize',7,'FontWeight','normal')


%% Plot scatter plot of ranked residual

%     for i = 1:1:n
%         residual (i) = Dxy (i,3) - b*Dxy(i,2)-a;
%     end
% 
%     figure('Name', 'Ranked residual plot', 'NumberTitle','off');
%     hold off
%     plot (1:n, residual, 'bo', 'MarkerSize',5);
%     hold on
%     line ([ 0 n], [0 0], 'Color', 'r', 'LineWidth', 2);
%     %plot (0:0.05:n, 0, '-r', 'LineWidth', 2);
%     title ('Residual Plot', 'FontSize',18, 'Color', 'b', 'FontName', 'Courier','fontweight','b');
%     ylabel ('Residuals');
%     xlabel ('Rank (xi,yi)');

%% Plot cumsum_r statistics

%     hold off;
%     %Add zero for first value
%     figure('Name', 'cumsum statistic', 'NumberTitle','off');
%     %Plot cumsum, added of starting 0 value.
%     plot(0:n, horzcat([0],cumsum_r));
%     hold on;
%     title ('Linearity of tests', 'FontSize',18, 'Color', 'b', 'FontName', 'Courier','fontweight','b');
%     ylabel ('cumsum');
%     xlabel ('Rank (xi,yi)');
%     line ([ 0 n], [0 0], 'Color', 'r', 'LineWidth', 2)
end


