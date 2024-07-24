/*
Question: What are the top skills based on salary?
-Analyze the average salary associated with each skill for Data Analyst roles.
-Focus on job postings with specified salaries located in California.
-Why? It reals the impact of salary on the demand for certain skills and helps job seekers
    to identify the right skills to align with the top paying roles.
*/

-- project_sql\4_top_paying_skills.sql

-- This query identifies the top 5 paying skills for data analysts in the state of California.

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

/*
Three key insights based on the skills and average salary for data analysts in the state of California:

1. **High-Value Skills**: Skills like Asana, Scala, and MXNet command the highest average salaries, 
    with Asana leading at $235,000. This suggests that expertise in these areas is highly valued and well-compensated in the job market.

2. **Specialized Technologies**: Many specialized technologies and frameworks, such as Node, MongoDB, and Keras, also offer substantial average salaries, 
    ranging from approximately $174,000 to $180,000. These skills are likely in high demand for specific roles in software development and data science.

3. **Wide Range of Compensation**: The list shows a broad range of average salaries for various technical skills, from Asana at the top to GDPR at the bottom with $128,413.75. 
    This indicates diverse earning potential depending on the specific technology or skill set.

*/







