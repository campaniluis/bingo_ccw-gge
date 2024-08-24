# CCW/GGE Most Common N-Gram Expressions Bingo

## Description

CCW/GGE Most Common N-Gram* Expressions Bingo is a tool designed to identify and analyze the most frequent expressions in the United Nations' Convention on Certain Conventional Weapons (CCW) Group of Governmental Experts (GGE) on Lethal Autonomous Weapons Systems statements containing a specified target expression. This project helps in understanding common phrases and sentiments associated with specific terms within a given set of statements.

## Features

	•	Expression Filtering: Filters statements to focus on those containing a specific target expression.
	•	N-gram Frequency Analysis: Identifies the most common sequences of words (n-grams) within filtered statements.
	•	Sentiment Analysis: Assesses the sentiment of statements containing the target expression (available but not used for the project at hand).
	•	Text Tidying: Prepares and cleans text data for analysis by removing unnecessary elements.
	•	Multiple Filters: Provides several filtering scripts to focus on specific types of expressions, such as those related to ethics, legal instruments, and guiding principles.

## Project Structure

	•	accountability_filter.py: Filters statements based on accountability-related expressions.
	•	agreed_language_filter.py: Focuses on filtering agreed-upon language within statements.
	•	ethics_filter.py: Extracts statements related to ethical considerations.
	•	guiding_principles_filter.py: Filters statements for guiding principles.
	•	human_control_filter.py: Identifies statements discussing human control.
	•	ihl_filter.py: Filters statements related to international humanitarian law.
	•	legally_binding_instrument_filter.py: Focuses on legally binding instruments within statements.
	•	ngram_frequency.r: R script for analyzing the frequency of n-grams in the text.
	•	sentiment_analysis.r: R script to perform sentiment analysis on the filtered statements.
	•	session_word_frequency.r: Analyzes the word frequency during specific sessions.
	•	statement_tidier.r: Cleans and prepares statements for analysis.
	•	text_tidier.r: General text cleaning and tidying script.
	•	word_frequency.r: Analyzes word frequency across the dataset.

## Usage

	1.	Setup: Ensure that you have Python and R installed on your system.
	2.	Running Filters: Use the provided Python scripts to filter the dataset for relevant expressions.
	3.	Frequency Analysis: Run the R scripts to analyze the frequency of expressions in your filtered data.
	4.	Sentiment Analysis: Use the sentiment_analysis.r script to understand the sentiment in statements containing the target expression.

## Requirements

	•	Python 3.x
	•	R 4.x
	•	Required Python libraries: Listed in the scripts as import statements.
	•	Required R packages: Listed in the R scripts as library() statements.

## Contributing

If you would like to make a spin-off project based on this, feel free to reach out. 

## License

Copyright (C) 2024 [InterAgency Institute](www.interagency.institute)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of [InterAgency Institute](www.interagency.institute) shall not be used in advertising or otherwise to promote the sale, use or other dealings in this Software without prior written authorization from the [InterAgency Institute](www.interagency.institute).
