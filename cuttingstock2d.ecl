%
% Solve 2d cutting stock problem
%
% AUTHOR:	Taku Koyahata
% DATE		Oct 28, 2022
% DESCRIPTION:	solving 2d cutting stock problem
%
% USAGE
%	eclipse -f cuttingstock2d.ecl -e solve_cutting_stock_2d(INPUT_CSV_NAME,OUTPUT_CSV_NAME)
%	#you should set eclipse path into enviroment variable PATH in advance
%
% input csv format(all numbers must be integers):
%	1st line: container Width, container Height
%	2nd line: stock1 Width, stock1 Width
%	3rd line: stock2 Width, stock2 Height
%		...
%
% output csv format:	note stocks might be 90 degree rotated.
%	1st line: stock1 Left, stock1 Top, stock1 Width, stock1 Width
%	2nd line: stock2 Left, stock2 Top, stock2 Width, stock2 Width
%
%example below:
%in.csv:
%10,10
%3,3
%2,1
%6,7
%5,2
%
%command:
%	eclipse -f cuttingstock2d.ecl -e solve_cutting_stock_2d('in.csv','out.csv')
%
%stdout:
%  1  1  1  4  4  4  4  4------
%  1  1  1  4  4  4  4  4------
%  1  1  1---------------------
%  2  3  3  3  3  3  3---------
%  2  3  3  3  3  3  3---------
%---  3  3  3  3  3  3---------
%---  3  3  3  3  3  3---------
%---  3  3  3  3  3  3---------
%---  3  3  3  3  3  3---------
%---  3  3  3  3  3  3---------
%
%out.csv:
%0,0,3,3
%0,3,1,2
%1,3,6,7
%3,0,5,2
%
%NOTE: Though this program can genates other solutions with backtracking internally, 
%      by usage above user only get the first solution.
%      for getting other solutions, consider calling from PHP or Python libraries.
%

:- lib(ic).
:- lib(csv).

solve_cutting_stock_2d(InCSV,OutCSV):-

	csv_read(InCSV, CsvRows, []),
	CsvRows = [[CWidth,CHeight]|Panels],

	(foreach(CsvPanel,Panels),fromto(PanelVars,[Panel|RestPanels],RestPanels,[]),param(CWidth,CHeight) do
		(
			[CsvWidth,CsvHeight] = CsvPanel,
			Width#>=0,
			Height#>=0,
			(Width #= CsvWidth and Height #= CsvHeight) or 
			(Width #= CsvHeight and Height #= CsvWidth),
			LeftX #:: 0..CWidth,
			TopY #:: 0..CHeight,
			0 #=<LeftX, LeftX #=< CWidth-Width,
			0 #=<TopY, TopY #=< CHeight-Height,
			Panel = [](LeftX,TopY,Width,Height)
		)
	),
	(fromto(PanelVars,[PickedupPanel|RestPanelVars],RestPanelVars,[]) do 
		(foreach(CheckPanel,RestPanelVars),param(PickedupPanel) do
			PickedupPanel = [](LeftX1,TopY1,Width1,Height1),
			CheckPanel    = [](LeftX2,TopY2,Width2,Height2),
			( LeftX2+Width2 #=< LeftX1 or LeftX1 + Width1 #=< LeftX2) or
			( TopY2+Height2 #=< TopY1 or TopY1 + Height1 #=< TopY2)

		)
	),
	term_variables(PanelVars,Flatten),
	labeling(Flatten),

	%visualization, csv out
	open(OutCSV, write, OutStrm),
	dim(VisDim,[CWidth,CHeight]),
	( foreach([](Left,Top,Width,Height),PanelVars),count(Idx,1,_),param(VisDim,OutStrm) do

	
		write(OutStrm,Left),write(OutStrm,","),
		write(OutStrm,Top),write(OutStrm,","),
		write(OutStrm,Width),write(OutStrm,","),
		writeln(OutStrm,Height),
		( for(Y,Top+1,Top+Height),param(VisDim,Idx,Width,Left)  do
			( for(X, Left+1, Left+Width),param(VisDim,Y,Idx) do
				%VisDim[X,Y] = Idx
				arg([X,Y], VisDim, Idx)
			)
		)
	),
	( for(Y,1,CHeight),param(VisDim,CWidth)  do
		(for(X, 1, CWidth),param(VisDim,Y) do
			arg([X,Y], VisDim, Elem),
			nonvar(Elem)->printf("%3d",[Elem]);printf("---",[])
		),
		nl
	),
	close(OutStrm).
