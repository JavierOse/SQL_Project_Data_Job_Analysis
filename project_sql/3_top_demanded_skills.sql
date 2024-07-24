/*
Question: What are the most in-demand skills for data analysts in California?
-Join the job_postings_fact and job_skills_dim tables using INNER JOIN similar to the second query.
-Identify the top 5 most in-demand skills.
-Focus on all job postings in California.
-Why? Highlighting the top 5 skills allows for more visibility into the data and meaningful insights for job seekers.
*/

-- project_sql\3_top_demanded_skills.sql

-- This query identifies the top 5 most in-demand skills for data analysts in the state of California.

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

/*
Three Key Insights:

1. **High Demand for SQL**: SQL stands out as the most in-demand skill, with a significantly higher demand count (5111) compared to other skills. 
    This indicates that proficiency in SQL is crucial for data-related roles.

2. **Versatility with Excel and Tableau**: Excel (3695) and Tableau (3288) are also highly sought-after skills, 
    reflecting the importance of data visualization and spreadsheet proficiency in data analysis tasks.

3. **Programming Skills Valued**: Python (3016) and R (1885) show substantial demand, 
    emphasizing the need for programming expertise to perform advanced data analysis and statistical computations in the industry.

*/



