---
title: "Student Performance Analysis Report"
author: "Hemant Borana"
date: "December 2025"
output: html_document
---

## Introduction

This report analyzes student performance data to understand factors affecting academic achievement. The dataset contains information about 100 students including demographics, study habits, and test scores in Math, Reading, and Writing.

## Data Loading and Setup
```{r setup, message=FALSE, warning=FALSE}
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)

student_data <- read.csv("Student_Performance.csv")
```

## Data Overview
```{r data_overview}
str(student_data)
summary(student_data)
```

The dataset contains 100 students with 10 variables including demographic information and academic scores.

## Data Manipulation

### Creating Summary Statistics
```{r gender_summary}
gender_summary <- student_data %>%
  group_by(Gender) %>%
  summarise(
    Avg_Math = mean(MathScore),
    Avg_Reading = mean(ReadingScore),
    Avg_Writing = mean(WritingScore),
    Count = n()
  )
print(gender_summary)
```

**Interpretation:** The analysis shows differences in average scores between male and female students across subjects.
```{r parental_education}
parent_ed_summary <- student_data %>%
  group_by(ParentalEducation) %>%
  summarise(
    Avg_Math = mean(MathScore),
    Avg_Attendance = mean(Attendance),
    Total_Students = n()
  )
print(parent_ed_summary)
```

**Interpretation:** Students with parents holding Master's degrees show higher average math scores, suggesting parental education may influence academic performance.

## Visualizations and Analysis

### 1. Gender Distribution
```{r plot1, fig.width=8, fig.height=6}
ggplot(student_data, aes(x = Gender, fill = Gender)) +
  geom_bar() +
  labs(title = "Student Distribution by Gender",
       x = "Gender",
       y = "Number of Students") +
  theme_minimal() +
  geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5)
```

**Interpretation:** The dataset shows a relatively balanced gender distribution with slightly more female students (54) compared to male students (46).

### 2. Study Hours vs Math Score
```{r plot2, fig.width=8, fig.height=6}
ggplot(student_data, aes(x = StudyHours, y = MathScore)) +
  geom_point(aes(color = Gender), size = 3, alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(title = "Relationship between Study Hours and Math Score",
       x = "Study Hours per Week",
       y = "Math Score") +
  theme_minimal()
```

**Interpretation:** The scatter plot with trend line suggests a positive correlation between study hours and math scores. Students who study more hours tend to achieve higher math scores.

### 3. Math Score Distribution
```{r plot3, fig.width=8, fig.height=6}
ggplot(student_data, aes(x = MathScore)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Math Scores",
       x = "Math Score",
       y = "Frequency") +
  theme_minimal() +
  geom_vline(aes(xintercept = mean(MathScore)), 
             color = "red", linetype = "dashed", size = 1)
```

**Interpretation:** Math scores follow an approximately normal distribution with a mean around 68. Most students score between 55 and 80, with few students at the extreme low or high ends.

### 4. Scores by Parental Education
```{r plot4, fig.width=10, fig.height=6}
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
```

**Interpretation:** Box plots reveal that students whose parents have higher education levels (Master's degree) tend to have higher median scores and less variability compared to other groups.

### 5. Score Trends by Age
```{r plot5, fig.width=8, fig.height=6}
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
```

**Interpretation:** The line chart shows how average scores vary across different age groups, revealing patterns in academic performance as students mature.

## Key Findings

1. **Gender Differences:** Female students show higher average writing scores while male students perform slightly better in math
2. **Study Hours Impact:** Positive correlation between study hours and academic performance
3. **Parental Education:** Students with highly educated parents tend to perform better academically
4. **Score Distribution:** Most students perform at average to above-average levels
5. **Age Trends:** Performance varies across age groups with different patterns for different subjects

## Conclusion

This analysis reveals multiple factors influencing student performance including study habits, parental education background, and demographics. Schools and educators can use these insights to develop targeted interventions for improving student outcomes.