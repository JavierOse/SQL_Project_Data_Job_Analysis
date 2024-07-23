/*
Questions: What are the top-paying data analyst jobs?
-Identify the top 15 highest-paying Data Analyst roles that are available in California.
-Focus on job postings with specified salaries (remove NULLS).
-Why? Highlighting the top 15 paying roles allows for more visibility into the data and meaningful insights.
*/

-- project_sql\1_top_paying_jobs.sql

-- This query identifies the top 15 highest-paying Data Analyst roles that are available in California.

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