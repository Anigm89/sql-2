/* Relación tipo 1:1 */
-- PASO 1
CREATE TABLE usuarios (
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    edad INT
)


-- PASO 2
CREATE TABLE roles(
	id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
)


-- PASO 3
ALTER TABLE usuarios ADD COLUMN id_rol INT;
ALTER TABLE usuarios ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);

update usuarios set id_rol = 2 where id_usuario = 1;
update usuarios set id_rol = 1 where id_usuario = 2;
update usuarios set id_rol = 3 where id_usuario = 20;
update usuarios set id_rol = 4 where id_usuario = 12;

-- PASO 4
SELECT  usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol  FROM usuarios JOIN roles ON usuarios.id_rol = roles.id_rol

/* ---- Relación tipo 1:N  -------------------------------------------  */

-- PASO 1
CREATE TABLE categorias(
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
)


-- PASO 2
ALTER TABLE usuarios ADD COLUMN id_categoria INT

-- PASO 3
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 5, 9, 13, 17);
UPDATE usuarios SET id_categoria = 2 WHERE id_usuario IN (2,6,20);
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (4,18,19);
UPDATE usuarios SET id_categoria = 4 WHERE id_usuario IN (7,16);
UPDATE usuarios SET id_categoria = 5 WHERE id_usuario IN (8,15);
UPDATE usuarios SET id_categoria = 6 WHERE id_usuario IN (10,14);
UPDATE usuarios SET id_categoria = 7 WHERE id_usuario = 11;
UPDATE usuarios SET id_categoria = 8 WHERE id_usuario = 12;
UPDATE usuarios SET id_categoria = 9 WHERE id_usuario IN (3,13);
UPDATE usuarios SET id_categoria = 10 WHERE id_usuario = 5;


-- PASO 4
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria 
FROM usuarios 
JOIN roles 
JOIN categorias 
WHERE usuarios.id_rol = roles.id_rol 
AND usuarios.id_categoria = categorias.id_categoria
ORDER BY categorias.nombre_categoria

/* Relación tipo N:M */
-- PASO 1
CREATE TABLE usuarios_categorias(
	id_usuario_categoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)  
)

--ALTER TABLE usuarios_categorias ADD FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
ALTER TABLE usuarios_categorias ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)


-- PASO 2
INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10)

-- PASO 3
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria  
FROM usuarios
JOIN usuarios_categorias
JOIN roles
JOIN categorias
WHERE usuarios.id_usuario = usuarios_categorias.id_usuario
and usuarios.id_rol = roles.id_rol
AND categorias.id_categoria = usuarios_categorias.id_categoria
ORDER BY usuarios.id_usuario

-- más simple:
SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.edad, r.nombre_rol, c.nombre_categoria  
FROM usuarios u, usuarios_categorias uc, roles r, categorias c
WHERE u.id_usuario = uc.id_usuario
AND u.id_rol = r.id_rol
AND c.id_categoria = uc.id_categoria
ORDER BY u.id_usuario

-- solucion

SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria  
FROM usuarios
JOIN roles ON  usuarios.id_rol = roles.id_rol
JOIN usuarios_categorias ON usuarios.id_usuario = usuarios_categorias.id_usuario
JOIN categorias on usuarios_categorias.id_categoria = categorias.id_categoria
ORDER BY usuarios.id_usuario