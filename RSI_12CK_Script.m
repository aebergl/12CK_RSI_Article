
cd /Users/bergluae/AEBERGL/USR/BERGLUND/12CK_RSI
FileName = "DATA_Table.xlsx";

FontSize = 7;
LineWidth = 0.5;
GridLines = 'on';
FigureSize = [7,2.5];
AxisType = 'normal';
cMAP=GetPalette('Tab10');
MarkerSize = 75;
MarkerEdgeLineWidth = 0.5;
AlphaValue=0.8;
AlphaValueMarkerLine = 0.8;
MarkerEdgeColor = [0.1 0.1 0.1];
MarkerTypes = {'o','d','v','^','<','>'}';
MarkerTypes = repmat(MarkerTypes,10,1);

%%
% Figure 1A
SheetName="Proficiency";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);
X_Samples = "MGC" + wildcardPattern;
Y_Samples = "CLIA" + wildcardPattern;
Groups = table2array(T(X_Samples,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);


fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'equal';

% 12CK
x_var=table2array(T(X_Samples,'12CK'));
y_var=table2array(T(Y_Samples,'12CK'));

ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
min_xy = min([x_var;y_var]);
max_xy = max([x_var;y_var]);
NudgeVal = (max_xy - min_xy) / 25;
ah1.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah1.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('MGC 12CK');
ylabel('CLIA 12CK')
line(ah1,[ah1.XLim(1) ah1.XLim(2)],[ah1.YLim(1) ah1.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
% Str(1) = {sprintf('r = %.3f p = %0.3g',r_corr_P,p_corr_P)};
% Str(2) = {sprintf('\\rho = %.3f p = %0.3g',r_corr_S, p_corr_S)};
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah1,min_xy + NudgeVal/2,max_xy-NudgeVal/2,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');

% RSI
x_var=table2array(T(X_Samples,'RSI'));
y_var=table2array(T(Y_Samples,'RSI'));
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0 1];
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('MGC RSI');
ylabel('CLIA RSI')
line(ah2,[ah2.XLim(1) ah2.XLim(2)],[ah2.YLim(1) ah2.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah2,0.05,0.95,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');
legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

SavePDF_AEB('Figure_1A')
%%
% Figure 1B
SheetName="Repeatability";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);

Groups = table2array(T(:,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);


fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'square';

% A, 12CK
y_var=table2array(T(:,'12CK'));
n=length(y_var);
x_var=(1:n)';
ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
ah1.XLim=[0.5 n+0.5];
ah1.XTick=1:n;
ah1.XTickLabel=[];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('12CK')

% B, RSI
y_var=table2array(T(:,'RSI'));
n=length(y_var);
x_var=(1:n)';
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0.5 n+0.5];
ah2.XTick=1:n;
ah2.XTickLabel=[];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('RSI')

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')
SavePDF_AEB('Figure_1B')

%%
% Figure 2A
cMAP=GetPalette('Tab20');
MarkerTypes = {'o','o','d','d','^','^'}';
SheetName="O2O";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);

Groups = table2array(T(:,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);


fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'square';

% A, 12CK
y_var=table2array(T(:,'12CK'));
n=length(y_var);
x_var=(1:n)';
ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
ah1.XLim=[0.5 n+0.5];
ah1.XTick=1:n;
ah1.XTickLabel=[];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('12CK')

% B, RSI
y_var=table2array(T(:,'RSI'));
n=length(y_var);
x_var=(1:n)';
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0.5 n+0.5];
ah2.XTick=1:n;
ah2.XTickLabel=[];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('RSI')

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')
SavePDF_AEB('Figure_2A')


%%
% Figure 2B
cMAP=GetPalette('Tab10');
MarkerTypes = {'o','d','v','^','<','>'}';
MarkerTypes = repmat(MarkerTypes,10,1);
SheetName="Run1 vs Run2";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);

Groups = table2array(T(:,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);


fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'square';

% A, 12CK
y_var=table2array(T(:,'12CK'));
n=length(y_var);
x_var=(1:n)';
ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
ah1.XLim=[0.5 n+0.5];
ah1.XTick=1:n;
ah1.XTickLabel=[];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('12CK')

% B, RSI
y_var=table2array(T(:,'RSI'));
n=length(y_var);
x_var=(1:n)';
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0.5 n+0.5];
ah2.XTick=1:n;
ah2.XTickLabel=[];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('RSI')

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')
SavePDF_AEB('Figure_2B')


%%
% Figure 3
SheetName="LOD";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);

Groups = table2array(T(:,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);
SampleId = table2array(T(:,'Sample Id'));

fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'normal';

% A, 12CK
y_var=table2array(T(:,'12CK'));
n=length(y_var);
x_var=(1:n)';
ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
ah1.XLim=[0.5 n+0.5];
ah1.XTick=1:n;
ah1.XTickLabel=SampleId;
ah1.XTickLabelRotation=-45;
ah1.TickLabelInterpreter='none';
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('12CK')

% B, RSI
y_var=table2array(T(:,'RSI'));
n=length(y_var);
x_var=(1:n)';
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0.5 n+0.5];
ah2.XTick=1:n;
ah2.XTickLabel=SampleId;
ah2.XTickLabelRotation=-45;
ah2.TickLabelInterpreter='none';
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel('RSI')

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')
SavePDF_AEB('Figure_3')



%%

% Figure 4 Impact of macrodissection
SheetName="ImpMacroDiss";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);
X_Samples = wildcardPattern + "_A";
Y_Samples = wildcardPattern + "_B";
Groups = table2array(T(X_Samples,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);


fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'equal';

% 12CK
x_var=table2array(T(X_Samples,'12CK'));
y_var=table2array(T(Y_Samples,'12CK'));

ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
min_xy = min([x_var;y_var]);
max_xy = max([x_var;y_var]);
NudgeVal = (max_xy - min_xy) / 25;
ah1.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah1.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Macrodissection Study 1 12CK');
ylabel('Macrodissection Study 2 12CK')
line(ah1,[ah1.XLim(1) ah1.XLim(2)],[ah1.YLim(1) ah1.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
% Str(1) = {sprintf('r = %.3f p = %0.3g',r_corr_P,p_corr_P)};
% Str(2) = {sprintf('\\rho = %.3f p = %0.3g',r_corr_S, p_corr_S)};
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah1,min_xy + NudgeVal/2,max_xy-NudgeVal/2,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');

% RSI
x_var=table2array(T(X_Samples,'RSI'));
y_var=table2array(T(Y_Samples,'RSI'));
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0 1];
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Macrodissection Study 1 RSI');
ylabel('Macrodissection Study 2 RSI');
line(ah2,[ah2.XLim(1) ah2.XLim(2)],[ah2.YLim(1) ah2.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah2,0.05,0.95,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');
legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

SavePDF_AEB('Figure_4')


%%
%Figure 5A

SheetName="SurgVsBiop_A";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);
X_Samples = "Surg_" + wildcardPattern;
Y_Samples = "PB_" + wildcardPattern;
Groups = table2array(T(X_Samples,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);


fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'equal';

% 12CK
x_var=table2array(T(X_Samples,'12CK'));
y_var=table2array(T(Y_Samples,'12CK'));

ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
min_xy = min([x_var;y_var]);
max_xy = max([x_var;y_var]);
NudgeVal = (max_xy - min_xy) / 25;
ah1.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah1.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Surgery 12CK');
ylabel('Biopsy 12CK')
line(ah1,[ah1.XLim(1) ah1.XLim(2)],[ah1.YLim(1) ah1.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
% Str(1) = {sprintf('r = %.3f p = %0.3g',r_corr_P,p_corr_P)};
% Str(2) = {sprintf('\\rho = %.3f p = %0.3g',r_corr_S, p_corr_S)};
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah1,min_xy + NudgeVal/2,max_xy-NudgeVal/2,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');

% RSI
x_var=table2array(T(X_Samples,'RSI'));
y_var=table2array(T(Y_Samples,'RSI'));
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0 1];
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Surgery RSI');
ylabel('Biopsy RSI')
line(ah2,[ah2.XLim(1) ah2.XLim(2)],[ah2.YLim(1) ah2.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah2,0.05,0.95,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');
legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

SavePDF_AEB('Figure_5A')


%%
%Figure 5B

SheetName="SurgVsBiop_B";
opts=detectImportOptions('DATA_Table.xlsx','Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1);
T=readtable('DATA_Table.xlsx',opts);
X_Samples = "surgery_" + wildcardPattern;
Y_Samples = "biopsy_" + wildcardPattern;
Groups = table2array(T(X_Samples,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);


fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = FigureSize;
th = tiledlayout(fh,1,2,'TileSpacing','tight','padding','compact');
AxisType = 'equal';

% 12CK
x_var=table2array(T(X_Samples,'12CK'));
y_var=table2array(T(Y_Samples,'12CK'));

ah1 = nexttile(th);
set(ah1,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah1.LineWidth = LineWidth;
ah1.Colormap=cMAP;
axis(AxisType);
min_xy = min([x_var;y_var]);
max_xy = max([x_var;y_var]);
NudgeVal = (max_xy - min_xy) / 25;
ah1.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah1.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Surgery 12CK');
ylabel('Biopsy 12CK')
line(ah1,[ah1.XLim(1) ah1.XLim(2)],[ah1.YLim(1) ah1.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
% Str(1) = {sprintf('r = %.3f p = %0.3g',r_corr_P,p_corr_P)};
% Str(2) = {sprintf('\\rho = %.3f p = %0.3g',r_corr_S, p_corr_S)};
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah1,min_xy + NudgeVal/2,max_xy-NudgeVal/2,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');

% RSI
x_var=table2array(T(X_Samples,'RSI'));
y_var=table2array(T(Y_Samples,'RSI'));
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
ah2.XLim=[0 1];
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Surgery RSI');
ylabel('Biopsy RSI')
line(ah2,[ah2.XLim(1) ah2.XLim(2)],[ah2.YLim(1) ah2.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah2,0.05,0.95,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');
legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

SavePDF_AEB('Figure_5B')