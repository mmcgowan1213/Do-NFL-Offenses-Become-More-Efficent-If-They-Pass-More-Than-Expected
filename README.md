# Do-NFL-Offenses-Become-More-Efficent-If-They-Pass-More-Than-Expected

Do NFL teams that pass more than expected generate more EPA (Expected Points Added)?

This project uses NFL play-by-play data from the 2025 regular season to examine the relationship between Pass Over Expected 
and offensive efficiency measured by EPA per play. 
Pass Over Expected measures how much more or less likely 
a team was to pass on a given play compared to what a model would predict based on game situation.
Things like down, distance, and score.

I used nflreadr, tidyverse, and nflplotR for this project.

Play-by-play data was sourced using nflreadr::load_pbp(2025), 
filtered to regular season passing plays with valid pass_oe and epa values. 
Division information was joined in from nflreadr::load_teams().

Visualization 1 - Bar Chart (geom_col):
Ranks all 32 NFL teams by average Pass Over Expected for the 2025 season. 
Team logos are placed at the base of each bar using geom_nfl_logos(). 
I felt the light to dakr blue made the chart more aesthetically pleasing. 

Visualization 2 - Scatter Plot (geom_nfl_logos + geom_smooth):
Plots each team's average Pass Over Expected against their mean EPA per play,
with a linear regression line. 
Shows whether passing more than expected correlates with generating more value per play.

Visualization 3 - Box Plot (geom_boxplot):
Shows the distribution of EPA per pass play broken down by division. 
Divisions are sorted by median EPA using reorder(). 
Each box represents the interquartile range, the black line is the median, and the whiskers show the spread of the data.

Key Findings:
There is a positive relationship between Pass Over Expected and EPA.
Teams that passed more aggressively than expected tended to generate more value per play
The Rams led the league in Pass Over Expected while the Jets were the most conservative
The NFC West led all divisions in median EPA per pass play while the AFC North sat at the bottom
However, Pass Over Expected alone does not guarantee success — some high Pass OE teams still produced negative EPA, suggesting execution matters as much as aggressiveness

This project was done as my final project for Dr. Congelio's SPRT 313 Sports analytics course at Kutztown University.
