# Introduction
🚀 Welcome to the Data Job Market Exploration Project! This project is part of a comprehensive course I followed on YouTube, designed to delve deep into the world of data analyst roles. Here, we explore:
- 💰 Top-paying jobs in the data industry
- 🔥 In-demand skills that make you a standout candidate
- 📊 Where high-demand skills intersect with high salaries in data analytics

If you're interested in SQL queries, you can check them out here: [project_sql folder](/project_sql/).
# Background
I embarked on this project to refresh my memory and enhance my skills in SQL. To achieve this, I followed an in-depth SQL course on YouTube, which provided a comprehensive overview of the language. This course not only helped me regain my knowledge of SQL but also offered numerous opportunities to practice and refine my skills.

Moreover, this course provided valuable insight into the job market, assisting me in understanding the in-demand skills for a Data Analyst position. Throughout the course, I worked with a database that contained information about job postings, including job titles, salaries, locations, and essential skills. This practical experience was instrumental in developing my abilities and preparing me for the job market.

As a culminating task, the course presented this project, allowing me to showcase the work I accomplished and the skills I honed. If you're interested in following the same course, you can find it [SQL Course](https://lukebarousse.com/sql).

### Here are the questions I answered through my SQL Queries:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills?

*I specifically tailored my analysis to meet my needs by focusing only on Data Analyst roles in California.*
# Tool Utilized
In this project, I utilized several tools to perform my analysis and manage my work effectively. Here’s a quick overview of each tool and its role in the project:

- **SQL**: I used SQL (Structured Query Language) to query the database and extract relevant information. SQL allowed me to filter, sort, and aggregate data to answer the specific questions I had about data analyst roles.

- **PostgreSQL**: PostgreSQL served as the database management system for this project. It hosted the database containing job postings and related information. I executed my SQL queries on this platform to retrieve the necessary data.

- **Visual Studio Code**: Visual Studio Code (VS Code) was my primary code editor for writing and testing SQL queries. Its features, such as syntax highlighting and extensions, made it easier to work with SQL and manage my scripts.

- **Git/GitHub**: Git was used for version control, enabling me to track changes and maintain different versions of my code. GitHub served as the repository to store and share my project, making it accessible for collaboration and showcasing my work.

By leveraging these tools, I was able to conduct a thorough analysis and present my findings effectively.
# My Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market in California. Here’s how I approached each question:

## 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on jobs in California. This query highlights the high-paying opportunities in the field.
```sql
SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%CA%' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    15;
```
Three key insights based on the salary of data analyst roles in California:

1. **High Salary Range**: The data analyst and related positions in the San Francisco Bay Area, 
    particularly with companies like Anthropic and OpenAI, which offer exceptionally high average annual salaries, 
    with the highest listed at $350,000 for a Data Analyst position at Anthropic.

2. **Prominent Employers**: Major tech companies such as TikTok, Anthropic, OpenAI, and Genentech dominate the job listings,
    indicating high demand for data professionals within these organizations. 
    TikTok, in particular, has multiple job postings across various locations in California.

3. **Geographic Concentration**: The majority of these high-paying data roles are concentrated in San Francisco, CA, 
    and surrounding areas such as San Jose, Mountain View, and Sunnyvale, highlighting the region as a hotspot for lucrative data-related career opportunities.

![Top Paying Companies](assets\top_paying_roles.png)
*Bar graph visualizing the top salaries from companies for Data Analyst positions in California; ChatGPT generated this graph from my SQL query results*

## 2. Skills Required for Top-Paying Jobs
To understand what skills are required for the top-paying jobs for a Data Analyst Position in California, I joined the job postings and skills data table to analyze and create a meaningful insight into what skills companies value for higher compensation.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        name AS company_name,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%CA%' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        15
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```


Based on the top data analyst roles in California, here are the key insights regarding the most frequently mentioned skills:

**Top Skills:**
- **SQL**: The most frequently mentioned skill, appearing 12 times.
- **Python**: The second most common skill, with 8 mentions.
- **Tableau**: The third most common skill, mentioned 6 times.
- **R**: Appears frequently with 5 mentions.
- **SAS**: Also appears frequently with 4 mentions.

**Other Skills:**
- **Skills mentioned twice**: Express, NoSQL, Spark, MongoDB, Power BI, Flow.
- **Skills mentioned once**: Hadoop, Pandas, Cassandra, PostgreSQL, MySQL, Excel, Qlik, Matplotlib, Oracle, Scala, Asana, Snowflake, GitHub, Kafka.

These insights highlight the essential and desirable skills for data analyst roles in California, providing a clear focus for skill development.

![Top Paying Companies](assets\Top_Skills.png)

*Here is a bar chart that visualizes the skills for the top paying Data Analyst job in California with more than one mention; ChatGPT generated this graph from my SQL query results.*

## 3. In-Demand Skills For Data Analysts in CA
This query helped identify the most frequently requested skills in job postings, directing focus to high-demand areas.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.job_location LIKE '%CA%'
GROUP BY
  skills
ORDER BY
  demand_count DESC
LIMIT 5;
```
Three Key Insights:

1. **High Demand for SQL**: SQL stands out as the most in-demand skill, with a significantly higher demand count (5111) compared to other skills. 
    This indicates that proficiency in SQL is crucial for data-related roles.

2. **Versatility with Excel and Tableau**: Excel (3695) and Tableau (3288) are also highly sought-after skills, 
    reflecting the importance of data visualization and spreadsheet proficiency in data analysis tasks.

3. **Programming Skills Valued**: Python (3016) and R (1885) show substantial demand, 
    emphasizing the need for programming expertise to perform advanced data analysis and statistical computations in the industry.

    | Skills  | Demand Count |
    |---------|--------------|
    | SQL     | 5111         |
    | Excel   | 3695         |
    | Tableau | 3288         |
    | Python  | 3016         |
    | R       | 1885         |
*Table of the demand for the top 5 skills in data analyst job postings in the state of California*

## 4. Skills Based On Salary
The query presented assisted me in identifying the average salaries associated with different skills to reveal which skills are the highest paying as a Data Analyst in California.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location LIKE '%CA%'
GROUP BY
  skills
ORDER BY
  avg_salary DESC
LIMIT 30;
```
Three key insights based on the skills and average salary for data analysts in the state of California:

1. **High-Value Skills**: Skills like Asana, Scala, and MXNet command the highest average salaries, 
    with Asana leading at $235,000. This suggests that expertise in these areas is highly valued and well-compensated in the job market.

2. **Specialized Technologies**: Many specialized technologies and frameworks, such as Node, MongoDB, and Keras, also offer substantial average salaries, 
    ranging from approximately $174,000 to $180,000. These skills are likely in high demand for specific roles in software development and data science.

3. **Wide Range of Compensation**: The list shows a broad range of average salaries for various technical skills, from Asana at the top to GDPR at the bottom with $128,413.75. 
    This indicates diverse earning potential depending on the specific technology or skill set.

    | Skills    | Avg Salary   |
    |-----------|--------------|
    | Asana     | 235000.00    |
    | Scala     | 204666.67    |
    | MXNet     | 198000.00    |
    | Node      | 180000.00    |
    | MongoDB   | 176361.50    |
    | Keras     | 174040.00    |
    | Cassandra | 168694.83    |
    | DynamoDB  | 165000.00    |
    | Puppet    | 159640.00    |
    | Bash      | 159640.00    |

*Table of the Top 10 skills with the highest average salaries, but the demand count for these skills could be less*

## 5. Optimal Skills To Learn
This query identifies the most optimal skills to learn for data analysts in the state of California.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location LIKE '%CA%'
GROUP BY
    skills_dim.skill_id, skills_dim.skills
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC 
LIMIT 25;
```
Key insights about optimal skills to learn as a data analyst in California:

1. **High Demand Skills**: SQL, Python, and Tableau are the most in-demand skills 
    with demand counts of 419, 267, and 247 respectively.
    Learning these skills can significantly increase job opportunities.

2. **Top Paying Skills**: Spark, Express, and Airflow offer the highest average salaries 
    with salaries at $147,856.40, $133,310.27, and $130,350.71 respectively. 
    Focusing on these skills can lead to more lucrative positions.

3. **Balanced Skills**: Combining high-demand skills with top-paying skills, such as learning SQL, Python, Tableau, and Spark, 
    can optimize both job availability and earning potential in the data analyst field in California.
![Top Optimal Skills](assets\Optimal_Skills.png)
*The chart below illustrates the demand count and average salary for various skills based on job postings for data analyst roles in California. The blue bars represent the number of job postings that mention each skill, while the red line indicates the average salary associated with each skill.
This visualization helps identify which skills are in high demand and how they correlate with salary expectations. The chart was generated using data analysis techniques with the assistance of ChatGPT.*

# What I've Learned

- **Advanced Querying**: I enhanced my skills in writing complex SQL queries, including multi-table joins, subqueries, and common table expressions (CTEs).
- **Data Aggregation**: I learned how to effectively use aggregation functions such as `SUM()`, `AVG()`, `COUNT()`, and `GROUP BY` clauses to summarize and analyze data.
- **Data Filtering**: I practiced using `WHERE` clauses and various filtering techniques to extract specific subsets of data based on different criteria.
- **Real-World Data Analysis**: I developed the ability to analyze a real-world data set and generate meaningful insights using SQL, which is crucial for making data-driven decisions.

# Conclusions
This project has provided several valuable insights into the data analyst job market in California and the skills required for success. Here are the five most important insights:

1. **SQL is Essential**: SQL emerged as the most frequently mentioned skill in job postings, underscoring its critical importance for data analysts. Mastery of SQL is fundamental for querying databases and extracting actionable insights.

2. **High-Demand Skills**: In addition to SQL, other high-demand skills identified include Python, Tableau, Excel, and R. These tools and languages are essential for data analysis, visualization, and statistical computing.

3. **Skills Correlated with High Salaries**: Certain skills, such as Asana, Scala, MXNet, Node, and MongoDB, were associated with higher average salaries. Developing proficiency in these areas can significantly enhance earning potential.

4. **Importance of Versatility**: The analysis revealed the value of having a diverse skill set. Skills like Express, NoSQL, Spark, and Power BI, though mentioned less frequently, are still valuable and can set candidates apart in a competitive job market.

5. **Focus on California**: By concentrating on data analyst roles in California, the project highlighted the specific demands and salary expectations within this region. This regional focus provided tailored insights that are directly applicable to job seekers targeting opportunities in California.

These insights have been instrumental in guiding my learning path and career development, ensuring that I focus on the most relevant and valuable skills for a data analyst position in California.

## Closing Thoughts
This project has been an enriching experience, allowing me to refresh my existing knowledge and learn new concepts about SQL. Through hands-on practice and real-world data analysis, I have made significant strides in improving my ability to work with databases and perform comprehensive data analysis.

As a current job seeker, this project has been particularly educational in highlighting the skills that are in high demand for data analyst positions in California. I now have a clearer understanding of which areas to focus on for further development, ensuring that I am well-prepared for the job market.

While I have learned a lot, I recognize that there is always room for improvement. I am eager to continue developing my skills and knowledge, and I look forward to working on more projects that will contribute to my growth as a data analyst. The journey of learning and applying new skills is ongoing, and I am excited about the opportunities that lie ahead.











