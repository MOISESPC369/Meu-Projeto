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
