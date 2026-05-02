
library(shiny)
library(readr)
library(dplyr)
library(lubridate)
library(stringr)
library(DT)
library(ggplot2)

scores <- read_csv("2010-2025_scores.csv")
head(scores)
View(scores)

scores_clean <- scores |>
  mutate(
    GameDate_clean = str_remove(GameDate, "(st|nd|rd|th)$"),
    GameDate_full = paste(GameDate_clean, Season),
    GameDate = suppressWarnings(mdy(GameDate_full)),
    total_points = HomeScore + AwayScore,
    point_diff = abs(HomeScore - AwayScore),
    winner = ifelse(HomeScore > AwayScore, HomeTeam, AwayTeam),
    loser = ifelse(HomeScore < AwayScore, HomeTeam, AwayTeam),
    home_win = HomeScore > AwayScore
  )
regular <- scores_clean |>
  filter(GameStatus == "FINAL") |>
  filter(str_detect(Week, "^WEEK")) |>
  mutate(
    week_num = as.numeric(str_extract(Week, "\\d+"))
  )

#Season Summary
season_summary <- regular |>
  group_by(Season) |>
  summarise(
    avg_points = mean(total_points, na.rm = TRUE),
    avg_diff = mean(point_diff, na.rm = TRUE),
    games = n(),
    high_scoring = sum(total_points >= 50, na.rm = TRUE),
    close_games = sum(point_diff <= 3, na.rm = TRUE),
    .groups = "drop"
  )

#Top Games
top_games <- regular |>
  arrange(desc(total_points)) |>
  slice_head(n = 10)

closest_games <- regular |>
  arrange(point_diff) |>
  slice_head(n = 10)

# Team Summary
team_summary <- regular |>
  mutate(team = winner) |>
  group_by(team, Season) |>
  summarise(
    wins = n(),
    avg_points_scored = mean(total_points, na.rm = TRUE),
    avg_point_diff = mean(point_diff, na.rm = TRUE),
    .groups = "drop"
  )

# Home vs Away
home_away_summary <- regular |>
  summarise(
    avg_home_score = mean(HomeScore, na.rm = TRUE),
    avg_away_score = mean(AwayScore, na.rm = TRUE),
    home_win_rate = mean(home_win, na.rm = TRUE)
  )

# Points distribution
points_distribution <- regular |>
  summarise(
    mean_points = mean(total_points),
    median_points = median(total_points),
    sd_points = sd(total_points),
    min_points = min(total_points),
    max_points = max(total_points)
  )

#Heatmap 
week_season_summary <- regular |>
  group_by(Season, week_num) |>
  summarise(
    avg_points = mean(total_points, na.rm = TRUE),
    .groups = "drop"
  )
pointdiff_heat_data <- regular |>
  group_by(Season, week_num) |>
  summarise(
    avg_diff = mean(point_diff, na.rm = TRUE),
    .groups = "drop"
  )

# Define UI for application that draws a histogram
ui <- navbarPage(
  "NFL Scoring Explorer (2010-2025)",
  
  tabPanel(
    "Overview",
    sidebarLayout(
      sidebarPanel(
        helpText("League-wide scoring trends and summaries.")
      ),
      mainPanel(
        fluidRow(
          column(
            width = 6,
            h4("Average Points per Season"), 
            plotOutput("season_points_plot")
          ),
          column(
            width = 6, 
            h4("High-Scoring Games per Season"),
            plotOutput("season_high_scoring_plot")
          )
        ),
        fluidRow(
          column(
            width = 6,
            h4("Home vs Away Summary"),
            tableOutput("home_away_table")
          ),
          column(
            width = 6,
            h4("Points Distribution"),
            tableOutput("points_dist_table")
          )
        )
      )
    )
  ),
  tabPanel(
    "Team Explorer",
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "team",
          "Choose a Team:",
          choices = sort(unique(c(regular$HomeTeam, regular$AwayTeam)))
        )
      ),
      mainPanel(
        h4(textOutput("team_title")),
        plotOutput("team_season_points"),
        br(),
        plotOutput("team_wins_plot")
      )
    )
  ),
  tabPanel(
    "Games",
    sidebarLayout(
      sidebarPanel(
        helpText("Top 10 highest scoring and closest games.")
      ),
      mainPanel(
        h4("Top 10 Highest-Scoring Games"),
        DTOutput("top_games_table"),
        br(),
        h4("Top 10 Closest Games"),
        DTOutput("closest_games_table")
      )
    )
  ),
   tabPanel(
    "Heatmaps",
    sidebarLayout(
      sidebarPanel(
        helpText("Scoring and point differential by week and season.")
      ),
      mainPanel(
        h4("Average Points by Week and Season"),
        plotOutput("week_season_heatmap"),
        br(),
        h4("Average Point Differential by Week and Season"),
        plotOutput("pointdiff_heatmap")
      )
    )
  )
)
          


# Define server logic required to draw a histogram
server <- function(input, output, session) {

   output$season_points_plot <- renderPlot({
     ggplot(season_summary, aes(x = Season, y = avg_points)) +
       geom_line(color = "steelblue", linewidth = 1.2) +
       geom_point(color = "steelblue", size = 2) +
       labs(x = "Season", y = "Avergae Points") + 
       theme_minimal(base_size = 14)
   })
   
   output$season_high_scoring_plot <- renderPlot({
     ggplot(season_summary, aes(x = Season, y = high_scoring)) +
       geom_col(fill = "purple") +
       labs(x = "Season", y = "High-Scoring Games (50+)") + 
       theme_minimal(base_size = 14)
   })
   
   output$home_away_table <- renderTable(home_away_summary, digits = 3)
   
   output$points_dist_table <- renderTable(points_distribution, digits = 2)
   
   team_data <- reactive({
     regular |>
       filter(HomeTeam == input$team | AwayTeam == input$team)
   })

   output$team_title <- renderText({
  paste("Team:", input$team)
})

output$team_season_points <- renderPlot({
  team_data() |>
    group_by(Season) |>
    summarise(
      avg_points = mean(total_points, na.rm = TRUE),
      .groups = "drop"
    ) |>
    ggplot(aes(x = Season, y = avg_points)) +
    geom_line(color = "darkorange", linewidth = 1.2) + 
    geom_point(size = 2, color = "darkorange") +
    labs(
      title = "Average Total Points in Games Involving Team",
      x = "Season",
      y = "Average Total Points"
    ) +
    theme_minimal(base_size = 14)
})
output$team_wins_plot <- renderPlot({
  team_summary |>
    filter(team == input$team) |>
    ggplot(aes(x = Season, y = wins)) +
    geom_col(fill = "darkgreen") +
    theme_minimal(base_size = 14)
})

# Games tables
output$top_games_table <- renderDT(datatable(top_games))

output$closest_games_table <- renderDT(datatable(closest_games))

# Heatmaps
output$week_season_heatmap <- renderPlot({
  ggplot(week_season_summary, aes(x = week_num, y = factor(Season), fill = avg_points)) +
    geom_tile(color = "white") +
    scale_fill_viridis_c(option = "plasma") +
    labs(x = "Week", y = "Season") +
    theme_minimal(base_size = 14)
})

output$pointdiff_heatmap <- renderPlot({
  ggplot(pointdiff_heat_data, aes(x = week_num, y = factor(Season), fill = avg_diff)) +
    geom_tile(color = "white") +
    scale_fill_viridis_c(option = "inferno")+
    theme_minimal(base_size = 14)
})
}

# Run the application 
shinyApp(ui = ui, server = server)

