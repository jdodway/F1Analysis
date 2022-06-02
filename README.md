# F1Analysis

## Formula 1

This project is to further explore and visually represent the metrics of Formula 1 racing. Formula 1 racing is the pinnacle of global motorsports and I fell in love with it during 2020. F1 first debuted in 1950 and has been growing with the innovation of technology, specifically motor vehicles. 

Formula 1 is currently made up of 20 driver's representing a team with a fellow driver, resulting in 10 teams. These teams are responsible for designing and creating a car for their pair of drivers, which includes the car's engine, battery, chassis, and front/rear wing. Each team has to follow manufacturer guidelins set be the Federation Internationale de l'Automobile governing body. The proper term for teams is "Constructors". 

The F1 season comprises a series of races on a variety of tracks throughout the whole world. There are tracks that have been around since the beginning of F1 and others that are brand new or currently being built. 

At the end of each race, drivers and constructors are respectively rewarded with points based on the position they finish in the race. At the end of the season, the driver and constructor with the most points is titled the World Drivers' Champion and World Constructors' Champion, respectively. Currently the point system goes as followed:


|  Position  | Points rewarded |
| ---------- | --------------- |
|      1     |        25       |
|      2     |        18       |
|      3     |        15       |
|      4     |        12       |
|      5     |        10       |
|      6     |         8       |
|      7     |         6       |
|      8     |         4       |
|      9     |         2       |
|     10     |         1       |
|    11-20   |         0       |

An additional point is rewarded for the driver and team with the fastest lap during each race.


## The F1 Data

The datasets are in forms of CSV files. They were downloaded from https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020 , then uploaded into a local MySQL Database. Due to the absence of some data from the set, I have scraped additional data from the official Formula 1 website of https://www.formula1.com/en/results.html .  

## MySQL
I utilized SQL to create a variety of desired tables, like qualifying times, fastest laps, driver nationality, and race results. That process if under the file named "F1-analysis.sql" . I have exported these tables in the form of csv files and they are located in the folder named "F1QueryResults" .  

## Python

### Cleaning and Scraping

The cleaning and scraping process being done in python can be found in the jupyter notebook called "F1CleanandScrape.ipynb".

### Analyzing and Visualizing

#### Driver and Constructor Championships Through the Years of F1

F1Championship.ipynb contains functions that output the season's top 5 drivers and the constructors they driver for, along with the top 5 constructors. These functions will also show the championship standings after each race for both the drivers and constructors. Due to some F1 seasons having a ridiculous amount of drivers and constructors, I have capped the graphing to the top 20 drivers and top 10 constructors. 

#### Drivers' Nationality

Since Formula 1 is a global sport, the pool of drivers can be diverse. However, there tends to be drivers from specific nations over the others, like Great Britain and Italy. F1Nations.ipynb , will inform you which nations have been represented and how many times they are represented by a driver.

#### Fastest Laps Through the Years for Specific Tracks

The most historic tracks are Silverstone in Great Britain, Spa in Belgium, Monza in Italy, and F1's Crown Jewel of Monaco. F1AllRaces.ipynb graphs the fastest lap from each race on these tracks, showing how they have changed through the years. These changes of laptimes are due to both track modifications and car modifications.

### Figure Location

All the outputed figures is located in the GraphsImages folder.


To Do:
* Tableau

