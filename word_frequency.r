library(dplyr)
library(readr)
library(ggplot2)
library(tidytext)

# Read the CSV file
df <- read_csv("tidied_text.csv")

# Remove stop words and count the frequency of each word
word_counts <- df %>%
  anti_join(stop_words, by = "word") %>%
  count(word, sort = TRUE)

# Display the top 20 most common words after removing stop words
top_20_words <- head(word_counts, 20)
print(top_20_words)

# Create a bar plot of the top 20 most common words
ggplot(top_20_words, aes(x = reorder(word, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 20 Most Common Words (Excluding Stop Words)", 
       x = "Word", 
       y = "Frequency") +
  theme_minimal()

# Save the plot
ggsave("top_20_words_no_stopwords.png", width = 10, height = 6)

# Calculate the percentage of total words for each word
total_words <- sum(word_counts$n)
word_counts <- word_counts %>%
  mutate(percentage = n / total_words * 100)

# Display the top 20 most common words with percentages
print(head(word_counts, 20))

# Calculate some statistics
total_unique_words <- nrow(word_counts)
words_used_once <- sum(word_counts$n == 1)
percentage_used_once <- (words_used_once / total_unique_words) * 100

# Print the summary statistics
cat("Total words after removing stop words:", total_words, "\n")
cat("Total unique words after removing stop words:", total_unique_words, "\n")
cat("Words used only once:", words_used_once, "\n")
cat("Percentage of words used only once:", round(percentage_used_once, 2), "%\n")