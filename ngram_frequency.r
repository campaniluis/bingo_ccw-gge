library(dplyr)
library(readr)
library(ggplot2)
library(tidytext)
library(stringr)
library(tidyr)  # Load the tidyr package

# Read the CSV file
df <- read_csv("statements_on_accountability.csv")

# Function to process n-grams
process_ngrams <- function(n) {
  df %>%
    unnest_tokens(word, Statement) %>%  # Tokenize the 'Statement' column
    group_by(session_date, session_shift) %>%
    summarise(text = paste(word, collapse = " "), .groups = "drop") %>%
    unnest_tokens(ngram, text, token = "ngrams", n = n) %>%
    count(ngram, sort = TRUE) %>%
    mutate(n_words = n)
}

# Process 2-grams to 7-grams
ngrams_list <- lapply(2:7, process_ngrams)

# Combine all n-grams
all_ngrams <- bind_rows(ngrams_list)

# Remove stop words from n-grams
data(stop_words)
all_ngrams_filtered <- all_ngrams %>%
  separate(ngram, into = paste0("word", 1:7), sep = " ", fill = "right") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word | is.na(word2),
         !word3 %in% stop_words$word | is.na(word3),
         !word4 %in% stop_words$word | is.na(word4),
         !word5 %in% stop_words$word | is.na(word5),
         !word6 %in% stop_words$word | is.na(word6),
         !word7 %in% stop_words$word | is.na(word7)) %>%
  unite(ngram, paste0("word", 1:7), sep = " ", na.rm = TRUE) %>%
  arrange(desc(n))

# Display the top 50 most common n-grams after removing stop words
top_50_ngrams <- head(all_ngrams_filtered, 50)
print("Top 50 most common n-grams after removing stop words:")
print(top_50_ngrams)

# Create a bar plot of the top 20 most common n-grams
p1 <- ggplot(top_50_ngrams, aes(x = reorder(ngram, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 50 Most Common N-grams in Statements that say 'Accountability' (2-7 words, Excluding Stop Words)", 
       x = "N-gram", 
       y = "Frequency") +
  theme_minimal()

print(p1)
ggsave("accountability_top_50_ngrams_no_stopwords.png", plot = p1, width = 12, height = 8)

# Calculate the percentage of total n-grams for each n-gram
total_ngrams <- sum(all_ngrams_filtered$n)
all_ngrams_filtered <- all_ngrams_filtered %>%
  mutate(percentage = n / total_ngrams * 100)

# Display the top 50 most common n-grams with percentages
print("Top 50 most common n-grams in Statements that say 'Accountability' with percentages:")
print(head(all_ngrams_filtered, 50))

# Calculate some statistics
total_unique_ngrams <- nrow(all_ngrams_filtered)
ngrams_used_once <- sum(all_ngrams_filtered$n == 1)
percentage_used_once <- (ngrams_used_once / total_unique_ngrams) * 100

# Print the summary statistics
cat("Total n-grams after removing stop words:", total_ngrams, "\
")
cat("Total unique n-grams after removing stop words:", total_unique_ngrams, "\
")
cat("N-grams used only once:", ngrams_used_once, "\
")
cat("Percentage of n-grams used only once:", round(percentage_used_once, 2), "%\
")

# Distribution of n-gram lengths
ngram_length_distribution <- all_ngrams_filtered %>%
  mutate(ngram_length = str_count(ngram, "\\S+")) %>%
  count(ngram_length) %>%
  mutate(percentage = n / sum(n) * 100)

print("Distribution of n-gram lengths:")
print(ngram_length_distribution)

# Plot the distribution of n-gram lengths
p2 <- ggplot(ngram_length_distribution, aes(x = factor(ngram_length), y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Distribution of N-gram Lengths", 
       x = "Number of Words in N-gram", 
       y = "Percentage") +
  theme_minimal()

print(p2)
ggsave("ngram_length_distribution.png", plot = p2, width = 10, height = 6)