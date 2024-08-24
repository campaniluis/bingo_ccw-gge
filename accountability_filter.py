import pandas as pd

def filter_statements_by_account(file_path):
    # Read the CSV file
    df = pd.read_csv(file_path)
    
    # Define a regex pattern to match the word 'account' or any of its derivatives (e.g., accountability)
    pattern = r'\baccount\w*'
    
    # Filter the DataFrame to keep only rows where 'Statement' contains the pattern
    filtered_df = df[df['Statement'].str.contains(pattern, case=False, na=False)]
    
    # Save the filtered DataFrame to a new CSV file
    filtered_df.to_csv("statements_on_accountability.csv", index=False)
    
    print("Filtered statements have been saved to 'statements_on_accountability.csv'.")

# Example usage:
filter_statements_by_account("tidied_statements.csv")