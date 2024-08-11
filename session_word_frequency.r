library(dplyr)
library(readr)
library(ggplot2)
library(tidytext)

# Read the CSV file (if it's not already in memory)
df <- read_csv("tidied_text.csv")

# Load the stop_words dataset from tidytext
stop_words <- tidytext::stop_words

# Create a combined session identifier
df <- df %>%
  mutate(session_id = paste(session_date, session_shift, sep = " - "))

# Remove stop words, group by session_id, count words, and get top 10 for each session_id
top_words_by_session <- df %>%
  anti_join(stop_words, by = "word") %>%
  group_by(session_id) %>%
  count(word, sort = TRUE) %>%
  top_n(10, n) %>%
  arrange(session_id, desc(n))

# Display the results
print(top_words_by_session)

# Calculate the number of unique sessions
num_sessions <- n_distinct(df$session_id)

# Create a faceted plot for each session
ggplot(top_words_by_session, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  facet_wrap(~ session_id, scales = "free_y", ncol = 2) +
  coord_flip() +
  labs(title = "Top 10 Most Common Words by Session (Excluding Stop Words)",
       x = "Word",
       y = "Frequency") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8))

# Save the plot
ggsave("top_10_words_by_session.png", width = 15, height = 5 * ceiling(num_sessions/2))

# Calculate some overall statistics
total_words <- sum(top_words_by_session$n)
total_unique_words <- n_distinct(top_words_by_session$word)

print(paste("Total sessions:", num_sessions))
print(paste("Total words in top 10 lists:", total_words))
print(paste("Total unique words in top 10 lists:", total_unique_words))