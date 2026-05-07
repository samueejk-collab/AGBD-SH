--1
SELECT FirstName,LastName FROM employees ORDER BY FirstName 
--2
SELECT tracks.name , tracks.Milliseconds FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId WHERE Albums.title = "Big Ones" 
ORDER BY Milliseconds DESC 
--3
SELECT Title , sum(UnitPrice) from tracks 
JOIN albums ON tracks.AlbumId = albums.AlbumId   
GROUP BY tracks.AlbumId
ORDER BY UnitPrice ASC LIMIT 10 
--4
SELECT tracks.name, Title, genres.name ,tracks.UnitPrice  from tracks
JOIN genres ON tracks.GenreId = genres.GenreId
JOIN albums ON tracks.AlbumId = albums.AlbumId
WHERE tracks.UnitPrice = 0.99 LIMIT 20
--5
SELECT tracks.name, Title, milliseconds, artists.name from tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId
ORDER BY tracks.milliseconds ASC LIMIT 20 
--6
SELECT 
emp.LastName AS empleado,
emp.Title AS Cargo,
jefe.LastName AS jefe,
COUNT(*) FROM employees emp
JOIN employees jefe ON emp.ReportsTo = jefe.EmployeeId
JOIN customers cus ON emp.EmployeeId = cus.SupportRepId
GROUP BY emp.EmployeeId
ORDER by jefe ASC
--7
SELECT 
e.FirstName AS NombreEmpleado,
e.LastName AS ApellidoEmpleado,
c.FirstName AS NombreCliente,
c.LastName AS ApellidoCliente
FROM employees e
JOIN customers c ON e.EmployeeId = c.SupportRepId
--8
SELECT 
c.FirstName AS NombreCliente, 
c.LastName AS ApellidoCliente, 
c.Address AS DireccionCliente,
i.InvoiceId AS FacturaCliente
FROM customers c JOIN invoices i ON c.CustomerId = i.CustomerId
--9
SELECT 
genres.Name AS Genero,
COUNT(tracks.TrackId) AS CantCanciones FROM genres
JOIN tracks ON genres.GenreId = tracks.GenreId
GROUP BY Genero
ORDER BY CantCanciones DESC
--10 
SELECT 
c.FirstName AS NombreCliente,
a.Name AS NombreArtista
FROM customers c, artists a 
JOIN invoices ON c.CustomerId = invoices.CustomerId
JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
JOIN tracks ON tracks.trackId = invoice_items.trackId
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId
GROUP BY NombreCliente , NombreArtista
--11
SELECT  
c.FirstName AS NombreCliente,
a.Name AS NombreArtista,
c.city AS Ciudad,
tracks.Name AS NombreCancion,
genres.Name AS Genero
FROM customers c, artists a 
JOIN invoices ON c.CustomerId = invoices.CustomerId
JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
JOIN tracks ON tracks.trackId = invoice_items.trackId
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId
JOIN genres ON genres.GenreId = tracks.GenreId
GROUP BY NombreCliente , NombreArtista
--12 
SELECT *
FROM employees
JOIN customers ON employees.EmployeeId = customers.SupportRepId
JOIN invoices ON customers.CustomerId = invoices.CustomerId
JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
JOIN tracks ON invoice_items.TrackId = tracks.TrackId
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId
JOIN genres ON tracks.GenreId = genres.GenreId
JOIN media_types ON tracks.MediaTypeId = media_types.MediaTypeId
JOIN playlist_track ON tracks.TrackId = playlist_track.TrackId
JOIN playlists ON playlist_track.PlaylistId = playlists.PlaylistId

--Parte I: Investigación y Análisis Crítico
--1
--UPDATE sin WHERE: se generan nuevas versiones o se sobrescriben todas las filas; muchas páginas se marcan como “sucias” en el buffer, se generan entradas de redo/undo y se actualizan índices.
--DELETE sin WHERE: todas las filas se marcan como borradas (o se eliminan físicamente según el motor); páginas afectadas se marcan sucias; en motores MVCC las filas quedan como versiones muertas hasta GC/VACUUM; espacio lógico liberado pero no necesariamente devuelto al SO

--2
--Una restricción FOREIGN KEY asegura la integridad referencial entre dos tablas: obliga a que los valores de una columna (clave foránea) en 
--la tabla hija existan en la columna primaria o única de la tabla padre (o sean NULL si se permite). 
--Permite definir acciones al borrar/actualizar el padre (CASCADE, SET NULL, RESTRICT/NO ACTION).
--Beneficio: evita referencias a filas inexistentes; consideración: añade sobrecarga y requiere buen diseño de índices.

--Al intentar DELETE en la tabla padre, la FOREIGN KEY aplica la política definida y evita referencias inválidas:
-- RESTRICT/NO ACTION: bloquea el DELETE si hay hijas.
-- CASCADE: borra automáticamente las filas hijas.
-- SET NULL: pone NULL en la clave foránea de las hijas.
-- SET DEFAULT: asigna el valor por defecto a la clave foránea.

--Parte II: Implementación Práctica (Caso Chinook)
--1. Gestión de Catálogo (INSERT)

INSERT INTO artists (Name)
VALUES("radiohead")

Execution finished without errors.
Result: query executed successfully. Took 0ms, 1 rows affected
At line 1:
INSERT INTO artists (Name)
VALUES("radiohead")

INSERT INTO albums (title, ArtistId )
VALUES("In rainbows", "276")

Execution finished without errors.
Result: query executed successfully. Took 0ms, 1 rows affected
At line 1:
INSERT INTO albums (title, ArtistId )
VALUES("In rainbows", "276")

INSERT INTO tracks (name, AlbumId, MediaTypeId, GenreId, Milliseconds, UnitPrice)
 VALUES ('all i need', "348", "2", "23",240274, 0.99), 
        ('Just', "348", "2", "23",240274, 0.99);

Execution finished without errors.
Result: query executed successfully. Took 0ms, 2 rows affected
At line 1:
INSERT INTO tracks (name, AlbumId, MediaTypeId, GenreId, Milliseconds, UnitPrice)
 VALUES ('all i need', "348", "2", "23",240274, 0.99), 
        ('Just', "348", "2", "23",240274, 0.99)

--2. Mantenimiento y Precios (UPDATE)

UPDATE employees
SET Address = "Av. Siempreviva 742", city = "Springfield"
WHERE EmployeeId = 3;

Execution finished without errors.
Result: query executed successfully. Took 0ms, 1 rows affected
At line 1:
UPDATE employees
SET Address = "Av. Siempreviva 742", city = "Springfield"
WHERE EmployeeId = 3

UPDATE tracks
SET UnitPrice = UnitPrice * 1.10
WHERE GenreId = 2;

Execution finished without errors.
Result: query executed successfully. Took 0ms, 130 rows affected
At line 1:
UPDATE tracks
SET UnitPrice = UnitPrice * 1.10
WHERE GenreId = 2

--3. Depuración de Registros (DELETE)

DELETE FROM artists
WHERE name = "Queen"

Execution finished with errors.
Result: FOREIGN KEY constraint failed
At line 1:
DELETE FROM artists
WHERE name = "Queen"

--Para que la sentencia funcione se debe borrar primero los registros de tracks de queen
--luego borrar los registros en albums de queen

DELETE FROM invoice_items
WHERE InvoiceId IN (
SELECT InvoiceId FROM invoices
WHERE InvoiceDate >= '2010-01-01' AND InvoiceDate < '2011-01-01'
)

Execution finished without errors.
Result: query executed successfully. Took 0ms, 0 rows affected
At line 1:
DELETE FROM invoice_items
WHERE InvoiceId IN (
SELECT InvoiceId FROM invoices
WHERE InvoiceDate >= '2010-01-01' AND InvoiceDate < '2011-01-01'
)

DELETE FROM invoices
WHERE InvoiceDate >= '2010-01-01' AND InvoiceDate < '2011-01-01'

Execution finished without errors.
Result: query executed successfully. Took 0ms, 83 rows affected
At line 1:
DELETE FROM invoices
WHERE InvoiceDate >= '2010-01-01' AND InvoiceDate < '2011-01-01';

--Se debe eliminar primero las filas de invoice_items 
--que referencian las facturas de 2010 para no violar la Foreign key
