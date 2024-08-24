import pandas as pd

def filter_statements_by_ethic(file_path):
    # Read the CSV file
    df = pd.read_csv(file_path)
    
    # Define a regex pattern to match 'ethic' or any of its derivatives
    pattern = r'\bethic\w*'
    
    # Filter the DataFrame to keep only rows where 'Statement' contains the pattern
    filtered_df = df[df['Statement'].str.contains(pattern, case=False, na=False)]
    
    # Save the filtered DataFrame to a new CSV file
    filtered_df.to_csv("statements_on_ethic.csv", index=False)
    
    print("Filtered statements have been saved to 'statements_on_ethic.csv'.")

# Example usage:
filter_statements_by_ethic("tidied_statements.csv")