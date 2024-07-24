/*
Questions: What skills are required for the top-paying data analyst jobs in California?
-Use the top 15 highest-paying Data Analyst roles that are available in California from the first query.
-Add the skills required for these roles to the query.
-Why? It will provide more details on the demand for certain skills for high paying roles
    and it will assist job seekers to develop their skills to align with the top salaries.
*/

-- project_sql\2_top_paying_job_skills.sql

--This query identifies the skills required for the top salary paying data analyst roles in California.

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

/*
Key insights from the analysis of the skills column based on the top data analyst roles in California:

    Top Skills:
        SQL is the most frequently mentioned skill, appearing 12 times.
        Python follows, with 8 mentions.
        Tableau is the third most common, with 6 mentions.
        R and SAS also appear frequently, with 5 and 4 mentions, respectively.
        Other Skills:

        Several skills appear twice: Express, NoSQL, Spark, MongoDB, Power BI, and Flow.
        Many other skills are mentioned once, including Hadoop, Pandas, Cassandra, PostgreSQL, MySQL, 
        Excel, Qlik, Matplotlib, Oracle, Scala, Asana, Snowflake, GitHub, and Kafka.
*/