# 2d-cutting-stock-problem solver written in ECLiPSe CLP

AUTHOR:	Taku Koyahata
 
DATE:		Oct 28, 2022
 
DESCRIPTION:	solving 2d cutting stock problem

## USAGE
You need to do below in advance:

- Install ECLiPSe CLP(http://www.eclipseclp.org/) into your server/pc  

- Set its executable program path into the PATH environment variable.

Then copy cuttingstock2d.ecl into your environment and prepare your input csv file, and execute this command on your shell/command prompt:

- eclipse -f cuttingstock2d.ecl -e "solve_cutting_stock_2d(INPUT_CSV_PATH,OUTPUT_CSV_PATH)"

After execution, output csv file will be generated.
  
## INPUT CSV FORMAT(all numbers must be integers)
 
1st line: container Width, container Height
 
2nd line: stock1 Width, stock1 Height
 
3rd line: stock2 Width, stock2 Height
 
...

## OUTPUT CSV FORMAT

(NOTE: Stocks might be 90 degree rotated. Y coordinate increases downward)
 
1st line: stock1 Left, stock1 Top, stock1 Width, stock1 Height
 
2nd line: stock2 Left, stock2 Top, stock2 Width, stock2 Height

...

## EXAMPLE
 
### in.csv
 
10,10
 
3,3
 
2,1
 
6,7
 
5,2
 
### command
 
eclipse -f cuttingstock2d.ecl -e "solve_cutting_stock_2d('in.csv','out.csv')"
  
 
### stdout
 
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
 
 
### out.csv
 
0,0,3,3
 
0,3,1,2
 
1,3,6,7
 
3,0,5,2
 
 
## NOTE
 
Though this program can generates other solutions with backtracking internally, 
 
by usage above user only gets the first solution.
       
For getting other solutions, consider calling from PHP or Python libraries.
