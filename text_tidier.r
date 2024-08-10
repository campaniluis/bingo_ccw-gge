library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Function to process a single CSV file
process_csv_with_day_word_number <- function(file, day_number) {
  df <- read_csv(file)
  if ("Statement" %in% colnames(df)) {
    words <- df %>%
      select(Statement) %>%
      mutate(Statement = tolower(Statement)) %>%
      mutate(word = strsplit(Statement, "\\s+")) %>%
      unnest(word) %>%
      mutate(word = str_remove_all(word, "[[:punct:]]")) %>%
      filter(nchar(word) > 0) %>%
      mutate(word_number = row_number(), day = day_number) %>%
      select(word_number, day, word)
    return(words)
  } else {
    print(paste("'Statement' column not found in", file))
    return(NULL)
  }
}

# Get all CSV files from the srcs folder
csv_files <- list.files(path = "srcs", pattern = "*.csv", full.names = TRUE)

# Process all CSV files with day and word number
all_words_with_day_word_number <- lapply(seq_along(csv_files), function(i) {
  process_csv_with_day_word_number(csv_files[i], i)
})
all_words_with_day_word_number <- do.call(rbind, all_words_with_day_word_number)

# Print summary
print("Summary of processed words with day and word number:")
print(summary(all_words_with_day_word_number))

# Save the combined words dataframe to a CSV file
output_file_with_day_word_number <- "tidied_text.csv"
write_csv(all_words_with_day_word_number, output_file_with_day_word_number)
print(paste("Combined words with day and word number saved to", output_file_with_day_word_number))

# Print the first few rows of the combined dataframe
print("First few rows of the combined dataframe:")
print(head(all_words_with_day_word_number, 10))

print("Done")