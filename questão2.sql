SELECT 
    s.name AS "departamento (escola)",
    COALESCE(COUNT(st.id), 0) AS "quantidade_empregados (estudantes)",
    ROUND(COALESCE(AVG(c.price), 0), 2) AS "media_salarial (preço médio curso)",
    COALESCE(MAX(c.price), 0) AS "maior_salario (preço máximo)",
    COALESCE(MIN(c.price), 0) AS "menor_salario (preço mínimo)"
FROM 
    schools s
LEFT JOIN 
    courses c ON s.id = c.school_id
LEFT JOIN 
    students st ON c.id = st.course_id
GROUP BY 
    s.id, s.name
ORDER BY 
    "media_salarial (preço médio curso)" DESC;