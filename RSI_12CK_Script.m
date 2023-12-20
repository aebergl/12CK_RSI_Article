

FileName = "Supplemental Table 1.xlsx";
FontSize = 7;
LineWidth = 0.5;
GridLines = 'on';
FigureSize = [7,2.5];
cMAP=GetPalette('Tab10');
MarkerSize = 75;
MarkerEdgeLineWidth = 0.5;
AlphaValue=0.8;
AlphaValueMarkerLine = 0.8;
MarkerEdgeColor = [0.1 0.1 0.1];
MarkerTypes = {'o','d','v','^','<','>'}';
MarkerTypes = repmat(MarkerTypes,10,1);
NudgeAmount = 20;
Label_12CK = "12CK GES";
Label_RSI = "RSI";


%%
% Figure 1A
SheetName="Proficiency";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);
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
NudgeVal = (max_xy - min_xy) / NudgeAmount;
ah1.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah1.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel(strcat("MCC ",Label_12CK));
ylabel(strcat("CLIA ",Label_12CK));
line(ah1,[ah1.XLim(1) ah1.XLim(2)],[ah1.YLim(1) ah1.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
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
xlabel(strcat("MCC ",Label_RSI));
ylabel(strcat("CLIA ",Label_RSI));
line(ah2,[ah2.XLim(1) ah2.XLim(2)],[ah2.YLim(1) ah2.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah2,0.05,0.95,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');
legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_1A.pdf')
exportgraphics(gcf,'Figure_1A.png','Resolution',600)

%%
% Figure 1B
SheetName="Repeatability";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);

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

min_y = min(y_var);
max_y = max(y_var);
NudgeVal = (max_y - min_y) / NudgeAmount;
ah1.YLim=[min_y-NudgeVal max_y+NudgeVal];

for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_12CK)

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
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_RSI)

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_1B.pdf')
exportgraphics(gcf,'Figure_1B.png','Resolution',600)


%%
% Figure 2A
cMAP=GetPalette('Tab20');
MarkerTypes = {'o','o','d','d','^','^'}';
SheetName="O2O";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);

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
min_y = min(y_var);
max_y = max(y_var);
NudgeVal = (max_y - min_y) / NudgeAmount;
ah1.YLim=[min_y-NudgeVal max_y+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_12CK)

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
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_RSI)

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_2A.pdf')
exportgraphics(gcf,'Figure_2A.png','Resolution',600)



%%
% Figure 2B
cMAP=GetPalette('Tab10');
MarkerTypes = {'o','d','v','^','<','>'}';
MarkerTypes = repmat(MarkerTypes,10,1);
SheetName="Run1 vs Run2";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);

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
min_y = min(y_var);
max_y = max(y_var);
NudgeVal = (max_y - min_y) / NudgeAmount;
ah1.YLim=[min_y-NudgeVal max_y+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_12CK)

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
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_RSI)

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_2B.pdf')
exportgraphics(gcf,'Figure_2B.png','Resolution',600)



%%
% Figure 3
SheetName="LOD";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);

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
min_y = min(y_var);
max_y = max(y_var);
NudgeVal = (max_y - min_y) / NudgeAmount;
ah1.YLim=[min_y-NudgeVal max_y+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_12CK)

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
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_RSI)

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_3.pdf')
exportgraphics(gcf,'Figure_3.png','Resolution',600)



%%

% Figure 4
cMAP=GetPalette('Tab10');
MarkerTypes = {'o','o','o','^','^','^','d','d','d'}';
MarkerTypes = repmat(MarkerTypes,10,1);



SheetName="ImpMacroDiss";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);

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
min_y = min(y_var);
max_y = max(y_var);
NudgeVal = (max_y - min_y) / NudgeAmount;
ah1.YLim=[min_y-NudgeVal max_y+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_12CK)

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
ah2.YLim=[0 1];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah2,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel('Sample');
ylabel(Label_RSI)

legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_4.pdf')
exportgraphics(gcf,'Figure_4.png','Resolution',600)



%%
%Figure 5A

cMAP=GetPalette('Tab10');
MarkerTypes = {'o','d','v','^','<','>'}';
MarkerTypes = repmat(MarkerTypes,10,1);


SheetName="SurgVsBiop_A";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);
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
NudgeVal = (max_xy - min_xy) / NudgeAmount;
ah1.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah1.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel(strcat("Surgery ",Label_12CK));
ylabel(strcat("Biopsy ",Label_12CK));

line(ah1,[ah1.XLim(1) ah1.XLim(2)],[ah1.YLim(1) ah1.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
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
xlabel(strcat("Surgery ",Label_RSI));
ylabel(strcat("Biopsy ",Label_RSI));
line(ah2,[ah2.XLim(1) ah2.XLim(2)],[ah2.YLim(1) ah2.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah2,0.05,0.95,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');
legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_5A.pdf')
exportgraphics(gcf,'Figure_5A.png','Resolution',600)


%%
%Figure 5B

SheetName="SurgVsBiop_B";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);
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
NudgeVal = (max_xy - min_xy) / NudgeAmount;
ah1.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah1.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
for i = 1:nGroups
    indx = strcmp(UniqueGroups(i),Groups);
    sh = scatter(ah1,x_var(indx),y_var(indx),MarkerSize,cMAP(i,:),MarkerTypes{i},'Linewidth',MarkerEdgeLineWidth,'MarkerFaceColor','flat','MarkerEdgeColor',MarkerEdgeColor);
    sh.MarkerEdgeAlpha = AlphaValueMarkerLine;
    sh.MarkerFaceAlpha = AlphaValue;
end
xlabel(strcat("Surgery ",Label_12CK));
ylabel(strcat("Biopsy ",Label_12CK));

line(ah1,[ah1.XLim(1) ah1.XLim(2)],[ah1.YLim(1) ah1.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
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
xlabel(strcat("Surgery ",Label_RSI));
ylabel(strcat("Biopsy ",Label_RSI));
line(ah2,[ah2.XLim(1) ah2.XLim(2)],[ah2.YLim(1) ah2.YLim(2)],'Color',[0.5 0.5 0.5],'lineWidth',1,'LineStyle','--');
[r_corr_P, p_corr_P] = corr(x_var,y_var,'type','Pearson','rows','pairwise');
[r_corr_S, p_corr_S] = corr(x_var,y_var,'type','Spearman','rows','pairwise');
Str(1) = {sprintf('r = %.3f',r_corr_P)};
Str(2) = {sprintf('\\rho = %.3f',r_corr_S)};
text(ah2,0.05,0.95,Str,'HorizontalAlignment','left','VerticalAlignment','top','Clipping','off','FontSize',FontSize,'FontWeight','normal');
legend(ah2,UniqueGroups,'Location','northeastoutside','Interpreter','none')

exportgraphics(gcf,'Figure_5B.pdf')
exportgraphics(gcf,'Figure_5B.png','Resolution',600)



%%
%Figure 6

SheetName="Concordance";
opts=detectImportOptions(FileName,'Sheet',SheetName,'FileType','spreadsheet','VariableNamingRule','preserve',"TextType","string",'RowNamesRange',1,'VariableNamesRange',1);
T=readtable(FileName,opts);
X_Samples = "MCC_" + wildcardPattern;
Y_Samples = "COV_" + wildcardPattern;
Groups = table2array(T(X_Samples,'Display Name'));
UniqueGroups = unique(Groups,'Stable');
nGroups = length(UniqueGroups);
AxisType = 'equal';

fh = figure('Name','Figure 1','Color','w','Tag','Figure 1','Units','inches','Colormap',cMAP);
fh.Position(3:4) = [7 5];
th = tiledlayout(fh,1,2,'TileSpacing','compact','padding','compact');
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

[fh, ~] = PassingBablok(x_var,y_var,strcat("MCC ",Label_12CK),strcat("COV ",Label_12CK),true,fh,ah1);


% RSI
x_var=table2array(T(X_Samples,'RSI'));
y_var=table2array(T(Y_Samples,'RSI'));
ah2 = nexttile(th);
set(ah2,'NextPlot','add','tag','Gene Sample Plot','Box','on','FontSize',FontSize,...
    'Linewidth',LineWidth,'XGrid','on','YGrid','on');
ah2.LineWidth = LineWidth;
ah2.Colormap=cMAP;
axis(AxisType);
min_xy = min([x_var;y_var]);
max_xy = max([x_var;y_var]);
NudgeVal = (max_xy - min_xy) / 25;
ah2.XLim=[min_xy-NudgeVal max_xy+NudgeVal];
ah2.YLim=[min_xy-NudgeVal max_xy+NudgeVal];
[fh, stats] = PassingBablok(x_var,y_var,strcat("MCC ",Label_RSI),strcat("COV ",Label_RSI),true,fh,ah2);

exportgraphics(gcf,'Figure_6.pdf')
exportgraphics(gcf,'Figure_6.png','Resolution',600)
