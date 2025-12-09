# Visualization 1: Bar Chart - Gender Distribution
library(ggplot2)

ggplot(student_data, aes(x = Gender, fill = Gender)) +
  geom_bar() +
  labs(title = "Student Distribution by Gender",
       x = "Gender",
       y = "Number of Students") +
  theme_minimal() +
  geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5)

ggsave("Plot1_Gender_Distribution.png", width = 8, height = 6)



# Visualization 2: Scatter Plot - Study Hours vs Math Score
ggplot(student_data, aes(x = StudyHours, y = MathScore)) +
  geom_point(aes(color = Gender), size = 3, alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(title = "Relationship between Study Hours and Math Score",
       x = "Study Hours per Week",
       y = "Math Score") +
  theme_minimal()

ggsave("Plot2_StudyHours_MathScore.png", width = 8, height = 6)



# Visualization 3: Histogram - Math Score Distribution
ggplot(student_data, aes(x = MathScore)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Math Scores",
       x = "Math Score",
       y = "Frequency") +
  theme_minimal() +
  geom_vline(aes(xintercept = mean(MathScore)), 
             color = "red", linetype = "dashed", size = 1) +
  annotate("text", x = mean(student_data$MathScore) + 10, y = 15, 
           label = paste("Mean =", round(mean(student_data$MathScore), 1)), 
           color = "red")

ggsave("Plot3_MathScore_Distribution.png", width = 8, height = 6)



# Visualization 4: Box Plot - Scores by Parental Education
library(tidyr)

scores_long <- student_data %>%
  select(ParentalEducation, MathScore, ReadingScore, WritingScore) %>%
  pivot_longer(cols = c(MathScore, ReadingScore, WritingScore),
               names_to = "Subject",
               values_to = "Score")

ggplot(scores_long, aes(x = ParentalEducation, y = Score, fill = ParentalEducation)) +
  geom_boxplot() +
  labs(title = "Score Distribution by Parental Education Level",
       x = "Parental Education",
       y = "Score") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("Plot4_Scores_ParentalEducation.png", width = 10, height = 6)



# Visualization 5: Line Chart - Average Scores by Age
age_trends <- student_data %>%
  group_by(Age) %>%
  summarise(
    Avg_Math = mean(MathScore),
    Avg_Reading = mean(ReadingScore),
    Avg_Writing = mean(WritingScore)
  ) %>%
  pivot_longer(cols = c(Avg_Math, Avg_Reading, Avg_Writing),
               names_to = "Subject",
               values_to = "Average_Score")

ggplot(age_trends, aes(x = Age, y = Average_Score, color = Subject, group = Subject)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  labs(title = "Average Scores Trend by Student Age",
       x = "Age",
       y = "Average Score") +
  theme_minimal() +
  scale_color_manual(values = c("Avg_Math" = "red", 
                                "Avg_Reading" = "blue", 
                                "Avg_Writing" = "green"),
                     labels = c("Math", "Reading", "Writing"))

ggsave("Plot5_Scores_Age_Trend.png", width = 8, height = 6)

