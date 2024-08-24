library(readr)
library(dplyr)
library(stringr)

# Function to process a single CSV file
process_csv_with_session_statement_number <- function(file) {
  tryCatch({
    # Extract the session date and shift from the filename
    filename <- basename(file)
    session_date <- str_extract(filename, "\\d{8}")
    session_date <- as.Date(session_date, format = "%Y%m%d")
    session_shift <- ifelse(str_detect(filename, "M"), "Morning", "Afternoon")
    
    # Read the CSV file
    df <- read_csv(file, show_col_types = FALSE)
    
    # Process the text data
    statements <- df %>%
      select(Statement) %>%
      mutate(Statement = tolower(Statement)) %>%
      mutate(statement_number = row_number(),
             session_date = session_date,
             session_shift = session_shift) %>%
      select(statement_number, session_date, session_shift, Statement)
    return(statements)
  }, error = function(e) {
    print(paste("Error processing file", file, ":", e$message))
    return(NULL)
  })
}

# Specify the files to process (assuming they're in the 'srcs' folder)
csv_files <- list.files(path = "srcs", pattern = "speaker_list - \\d{8}[MT]\\.csv$", full.names = TRUE)

# Print the list of CSV files
print("CSV files to be processed:")
print(csv_files)

# Process all specified CSV files
all_statements_with_session_statement_number <- lapply(csv_files, process_csv_with_session_statement_number)

# Remove NULL elements (if any)
all_statements_with_session_statement_number <- all_statements_with_session_statement_number[!sapply(all_statements_with_session_statement_number, is.null)]

# Combine all processed data
combined_statements <- do.call(rbind, all_statements_with_session_statement_number)

# Print summary
print("Summary of processed statements with session, date, shift, and statement number:")
print(summary(combined_statements))

# Save the combined statements dataframe to a CSV file
output_file_with_session_statement_number <- "tidied_statements.csv"
write_csv(combined_statements, output_file_with_session_statement_number)
print(paste("Combined statements with session, date, shift, and statement number saved to", output_file_with_session_statement_number))

# Print the first few rows of the combined dataframe
print("First few rows of the combined dataframe:")
print(head(combined_statements, 10))

print("Done")