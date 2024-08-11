# Load necessary libraries
library(dplyr)
library(tidytext)
library(ggplot2)
library(tidyr)

# Load the data
tidied_text <- read.csv('tidied_text.csv', stringsAsFactors = FALSE)

# Create an index for every 500 words
series <- tidied_text %>%
  group_by(session_date, session_shift) %>%
  mutate(word_count = 1:n(),
         index = word_count %/% 500 + 1) %>%
  ungroup()

# Join with Bing lexicon to assess sentiment
sentiment_data <- series %>%
  unnest_tokens(word, word) %>%
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(session_date, session_shift, index, sentiment) %>%
  ungroup()

# Spread the data and calculate net sentiment
sentiment_data <- sentiment_data %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(sentiment = positive - negative,
         session = paste(session_date, session_shift))

# Save the sentiment data to a CSV file
write.csv(sentiment_data, 'sentiment_analysis_results.csv', row.names = FALSE)

# Plot the data
ggplot(sentiment_data, aes(index, sentiment, fill = session)) +
  geom_bar(alpha = 0.5, stat = "identity", show.legend = FALSE) +
  facet_wrap(~ session, ncol = 2, scales = "free_x") +
  labs(title = "Sentiment Analysis by Session",
       x = "Index (500 words)",
       y = "Net Sentiment")

# Print the first few rows of the sentiment data
head(sentiment_data)