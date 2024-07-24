/*
Question: What are the most optimal skills to learn?
-Identify the skills that are in high demand with high average salaries for Data Analyst.
-Focus on job postings with specified salaries located in California.
-Why? It will identify crucial skills that offer job security (high demand) and financial benefits (high salary).
*/

-- sql_load\5_optimal_skills.sql

-- This query identifies the most optimal skills to learn for data analysts in the state of California.

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

/*
 Key insights about optimal skills to learn as a data analyst in California:

1. **High Demand Skills**: SQL, Python, and Tableau are the most in-demand skills 
    with demand counts of 419, 267, and 247 respectively.
    Learning these skills can significantly increase job opportunities.

2. **Top Paying Skills**: Spark, Express, and Airflow offer the highest average salaries 
    with salaries at $147,856.40, $133,310.27, and $130,350.71 respectively. 
    Focusing on these skills can lead to more lucrative positions.

3. **Balanced Skills**: Combining high-demand skills with top-paying skills, such as learning SQL, Python, Tableau, and Spark, 
    can optimize both job availability and earning potential in the data analyst field in California.

*/



