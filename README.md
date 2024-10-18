# Layoff Data Analysis (March 2020 - April 2024)

Welcome to the Layoff Data Analysis project repository. This project presents a comprehensive SQL-based analysis of layoff records from **March 2020 to April 2024**.

## Project Overview

The primary focus of this analysis is on data cleaning, transformation, and exploratory data analysis (EDA) to uncover significant trends, identify industries most affected by layoffs, and derive key statistics regarding layoffs across various companies during this period. Through this project, we aim to provide insights into the dynamics of the labor market, highlighting the impact of economic shifts on employment across different sectors.

## Goals

- **Identify Key Trends**: Determine the most affected industries and the overall impact of layoffs on the labor market.
- **Understand Geographic Impacts**: Analyze the countries most impacted by layoffs to understand regional differences.
- **Explore Company Behavior**: Examine how major companies navigated layoffs during economic shifts, especially during the COVID-19 pandemic.
- **Provide Actionable Insights**: Offer insights that can inform policymakers and industry leaders on workforce dynamics.

## Data Source

The data for this project has been sourced from [Layoffs.fyi](https://layoffs.fyi/). This dataset includes records of layoffs across various companies, providing insights into the impact of economic factors on employment during the COVID-19 pandemic.

### Dataset Columns:

- **Company**: The name of the company that implemented layoffs.
- **Location HQ**: The headquarters location of the company.
- **Industry**: The industry to which the company belongs.
- **Laid Off Count**: The number of employees laid off by the company.
- **Date**: The date on which the layoffs occurred.
- **Funds Raised (Millions)**: The amount of funds raised by the company, measured in millions.
- **Stage**: The stage of the company (e.g., startup, growth, etc.).
- **Country**: The country in which the company is located.
- **Percentage Laid Off**: The percentage of the workforce that was laid off.

## Tools Used

- **SQL**: Utilized for data cleaning and analysis, allowing for efficient querying and manipulation of the dataset.
- **Power BI**: Used to create interactive reports and visualizations, enabling a clear presentation of the insights derived from the data.

## Data Cleaning Process

The data cleaning process involved several key steps to ensure the accuracy and consistency of the layoff dataset:

1. **Schema Management**: Transferred the layoff data to a new schema for better organization and management.
2. **Identifying and Removing Duplicates**: Conducted a comprehensive examination of the dataset to identify and remove duplicate records.
3. **Standardizing Company Names**: Removed leading and trailing spaces from company names for consistency.
4. **Standardizing Location Data**: Reviewed and standardized location names, correcting variations.
5. **Date Format Correction**: Standardized date formats and corrected or removed invalid dates.
6. **Handling Missing Data**: Updated records with missing values to ensure accurate representation.
7. **Updating Industry Classification**: Revised industry classifications for specific companies.
8. **Changing Data Types**: Altered data types for certain columns to improve integrity and usability.
9. **Removing Incomplete Records**: Deleted records with missing values in critical fields to maintain dataset quality.

These steps collectively ensured that the dataset was clean, standardized, and ready for analysis.

## Exploratory Data Analysis (EDA)

In this section, we conducted exploratory data analysis to uncover trends and insights from the layoffs data. The following analyses were performed:

1. **Top Industries by Layoffs**: Identified the top 5 industries with the highest total number of layoffs.
2. **Average Layoff Percentage**: Calculated the average percentage of layoffs for the top 5 industries.
3. **Top Industries by Year**: Identified the top 3 industries with the highest layoffs for each year.
4. **Top Countries by Layoffs**: Retrieved the top 5 countries with the highest total number of layoffs.
5. **Layoffs by Stage**: Analyzed the top 5 stages with the highest total number of layoffs.
6. **Top Companies by Layoffs**: Identified the top 5 companies with the highest total number of layoffs.
7. **Average Layoff Percentage by Year**: Calculated the average percentage of layoffs for each year.
8. **Total Layoffs by Year**: Retrieved the total layoffs for each year.
9. **Top Companies by Year** We identified which companies laid off the most employees in each year, focusing on the top 3 companies annually. This analysis highlighted significant workforce reductions, particularly among major tech companies.

These analyses provide a comprehensive overview of layoffs across different industries, countries, and companies, helping to uncover key trends and insights related to the impact of economic factors during the specified timeframe.

## Key Insights

### Top Industries by Layoffs

Analyzing layoffs from March 2020 to April 2024 reveals the profound impact on several industries, with the **Retail**, **Consumer**, **Transportation**, **Travel**, and **Finance** sectors consistently ranking among the hardest hit.
![Top 5 Industries by Layoffs](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/top_5_industries.png)

#### Layoffs in 2020: The Impact of COVID-19

The onset of the COVID-19 pandemic in **2020** led to significant layoffs, particularly in **Transportation** and **Travel**. 
![Top 5 Industries by Layoffs in 2020](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/Top_5_industries_2020.png)

#### Persistent Challenges for Retail and Consumer Sectors

The **Retail** and **Consumer** sectors demonstrated a persistent trend of high layoffs over consecutive years, indicating ongoing vulnerabilities in these industries.


#### Rising Layoffs in Healthcare Post-COVID

Starting in **2022**, the **Healthcare** sector began to show increased layoffs, highlighting the evolving challenges as the industry adjusted to new realities post-COVID.

![Top 5 Industries by Layoffs in 2022 and 2023 ](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/comparison_2022_2023.png)

### Top Countries by Layoffs

- **United States**: Leading with 413,813 layoffs, heavily impacted by the pandemic.
- **India**: 51,234 layoffs, primarily in the tech and manufacturing sectors.
- **Germany**: 26,353 layoffs in manufacturing and automotive industries.
- **United Kingdom**: 19,019 layoffs influenced by pandemic-related disruptions.
- **Netherlands**: 18,445 layoffs mainly in logistics and technology sectors.

  ![Top 5 Countries by Layoffs](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/distri_by_country.png)

### Layoffs by Stage

- **Post-IPO**: The highest layoffs (337,845) occurred in post-IPO companies.
- **Acquired**: Companies that were acquired faced 59,457 layoffs.
  ![Top 5 Stage by Layoffs](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/layoffs_by_stage.png)

### Top Companies by Layoffs

- **Amazon**: 27,840 layoffs.
- **Meta**: 21,000 layoffs.
- **Tesla**: 14,500 layoffs.
- **Microsoft**: 14,058 layoffs.
- **Google**: 13,472 layoffs.
  ![Top 5 Companies by Layoffs](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/top_5_companies_by_layoffs.png)

### Total Layoffs by Year

After the COVID-19 pandemic, a significant increase in layoffs was observed across industries, with **90,916** layoffs recorded in just the first four months of **2024**.
![Yearly Total Layoffs](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/yearly_layoffs.png)

### Average Layoff Percentage by Year

The average percentage of layoffs peaked in **2021** at **0.61**, reflecting the severe impact of the pandemic on employment.
![Yearly Average Layoff Percentage](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/yearly_avg_percent_layoff.png)

### Top Companies by Year
The layoffs in 2023 were particularly notable, with Amazon, Google, and Microsoft together shedding over **40,000** jobs. This underscores the tech industry's adaptation to ongoing economic pressures and the push for operational efficiency.

![Top Companies by Year](https://github.com/jasnoorvirk26/Layoffs-Data-Analysis/blob/main/path/to/top_3_companies_layoffs_by_year.png)
## Conclusion

The analysis of layoff data from March 2020 to April 2024 highlights significant trends and shifts in the labor market influenced by the COVID-19 pandemic and subsequent economic conditions. Key industries such as Retail, Transportation, and Healthcare faced substantial workforce reductions, with major companies adapting to these challenges. These insights are crucial for understanding the evolving dynamics of the labor market and can help inform future strategies for workforce management.














