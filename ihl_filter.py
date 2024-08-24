import pandas as pd

def filter_statements_by_humanitarian_law_or_ihl(file_path):
    # Read the CSV file
    df = pd.read_csv(file_path)
    
    # Define a regex pattern to match the phrases 'humanitarian law' or 'IHL'
    pattern = r'\bhumanitarian law\b|\bIHL\b'
    
    # Filter the DataFrame to keep only rows where 'Statement' contains the pattern
    filtered_df = df[df['Statement'].str.contains(pattern, case=False, na=False)]
    
    # Save the filtered DataFrame to a new CSV file
    filtered_df.to_csv("statements_on_humanitarian_law_or_ihl.csv", index=False)
    
    print("Filtered statements have been saved to 'statements_on_humanitarian_law_or_ihl.csv'.")

# Example usage:
filter_statements_by_humanitarian_law_or_ihl("tidied_statements.csv")