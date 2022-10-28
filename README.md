# 2d-cutting-stock-problem solver written in ECLiPSe CLP

AUTHOR:	Taku Koyahata
 
DATE:		Oct 28, 2022
 
DESCRIPTION:	solving 2d cutting stock problem

## USAGE
You need to do below in advance:

- install ECLiPSe CLP(http://www.eclipseclp.org/) into your server/pc  

- set its excutable program path into PATH environment variable.



then copy cuttingstock2d.ecl into your environment and prepare your input csv file, and execute this command on your shell or command prompt:

- eclipse -f cuttingstock2d.ecl -e "solve_cutting_stock_2d(INPUT_CSV_PATH,OUTPUT_CSV_PATH)"
  
(you should set eclipse path into enviroment variable PATH in advance)

## input csv format(all numbers must be integers):
 
1st line: container Width, container Height
 
2nd line: stock1 Width, stock1 Height
 
3rd line: stock2 Width, stock2 Height
 
...

## output csv format:	

(note: stocks might be 90 degree rotated, y coodinate increses downward)
 
1st line: stock1 Left, stock1 Top, stock1 Width, stock1 Height
 
2nd line: stock2 Left, stock2 Top, stock2 Width, stock2 Height

## example below:
 
### in.csv:
 
10,10
 
3,3
 
2,1
 
6,7
 
5,2
 
### command:
 
eclipse -f cuttingstock2d.ecl -e "solve_cutting_stock_2d('in.csv','out.csv')"
  
 
### stdout:
 
  1  1  1  4  4  4  4  4------
   
  1  1  1  4  4  4  4  4------
   
  1  1  1---------------------
   
  2  3  3  3  3  3  3---------
   
  2  3  3  3  3  3  3---------
   
---  3  3  3  3  3  3---------
 
---  3  3  3  3  3  3---------
 
---  3  3  3  3  3  3---------
 
---  3  3  3  3  3  3---------
 
---  3  3  3  3  3  3---------
 
 
### out.csv:
 
0,0,3,3
 
0,3,1,2
 
1,3,6,7
 
3,0,5,2
 
 
### NOTE: 
 
Though this program can genates other solutions with backtracking internally, 
 
by usage above user only get the first solution.
       
for getting other solutions, consider calling from PHP or Python libraries.
