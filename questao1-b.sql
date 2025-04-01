SELECT 
    schools.name AS school_name,
    students.enrolled_at::date AS enrollment_date,
    COUNT(students.id) AS total_students,
    SUM(courses.price) AS total_revenue
FROM 
    students
JOIN 
    courses ON students.course_id = courses.id
JOIN 
    schools ON courses.school_id = schools.id
WHERE 
    courses.name LIKE 'data%' -- Filtra cursos que começam com "data"
GROUP BY 
    schools.name, students.enrolled_at::date
ORDER BY 
    students.enrolled_at DESC; -- Ordena do dia mais recente para o mais antigo
SELECT 
    school_name,
    enrollment_date,
    total_students,
    -- Soma acumulada da quantidade de alunos
    SUM(total_students) OVER (
        PARTITION BY school_name
        ORDER BY enrollment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_students,
    -- Média móvel de 7 dias
    AVG(total_students) OVER (
        PARTITION BY school_name
        ORDER BY enrollment_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7d,
    -- Média móvel de 30 dias
    AVG(total_students) OVER (
        PARTITION BY school_name
        ORDER BY enrollment_date
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS moving_avg_30d
FROM (
    SELECT 
        schools.name AS school_name,
        students.enrolled_at::date AS enrollment_date,
        COUNT(students.id) AS total_students
    FROM 
        students
    JOIN 
        courses ON students.course_id = courses.id
    JOIN 
        schools ON courses.school_id = schools.id
    WHERE 
        courses.name LIKE 'data%' -- Filtra cursos que começam com "data"
    GROUP BY 
        schools.name, students.enrolled_at::date
    ORDER BY 
        enrollment_date DESC
) AS daily_data;
