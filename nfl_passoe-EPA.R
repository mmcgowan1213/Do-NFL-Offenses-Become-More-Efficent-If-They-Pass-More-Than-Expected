"Do teams that pass more than expected generate more EPA"?

library(nflreadr)
library(tidyverse)
library(nflplotR)

pbp <- load_pbp(2025)

#1
passoe <- pbp %>% 
  filter(play_type == "pass", season_type == "REG",
         !is.na(pass_oe)) %>% 
  group_by(posteam) %>% 
  summarize(avg_pass_oe = mean(pass_oe),
            mean_epa = mean(epa)) %>% 
  arrange(-mean_epa)

ggplot(passoe, aes(x = reorder(posteam, avg_pass_oe),
                   y = avg_pass_oe)) +
  geom_col(aes(fill = avg_pass_oe)) +
  geom_nfl_logos(aes(team_abbr = posteam), width = 0.03) +
  labs(x = "Teams",
       y = "Pass Over Expected",
       title = "Which NFL Teams Pass More Than Expected?",
       subtitle = "2025 NFL Regular Season") +
  theme_minimal() +
  theme(axis.text.x = element_blank())

#2
ggplot(passoe, aes(x = avg_pass_oe,
                   y = mean_epa)) +
  geom_nfl_logos(aes(team_abbr = posteam), width = 0.05) +
  geom_smooth(method = "lm") +
  labs(x = "Pass Over Expected",
       y = "Mean EPA per Play",
       title = "Do Teams That Pass More Than Expected Generate More EPA?",
       subtitle = "2025 NFL Regular Season")

#3
teams_divisions <- nflreadr::load_teams()

passoe_plays <- pbp %>%
  filter(play_type == "pass", season_type == "REG",
         !is.na(pass_oe), !is.na(epa)) %>%
  left_join(teams_divisions %>% select(team_abbr, team_division),
            by = c("posteam" = "team_abbr"))

ggplot(passoe_plays, aes(x = epa,
                         y = reorder(team_division, epa, FUN = median),
                         fill = team_division)) +
  geom_boxplot(outlier.alpha = 0.2) +
  labs(x = "EPA per Pass Play",
       y = "Division",
       title = "EPA per Pass Play Varies Across NFL Divisions",
       subtitle = "2025 NFL Regular Season | Boxes show median and spread per division") +
  theme_minimal() +
  theme(legend.position = "none")