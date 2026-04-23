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
customers.FirstName AS NombreCliente, 
customers.LastName AS ApellidoCliente, 
customers.Address AS DireccionCliente,
invoices.InvoiceId AS FacturaCliente
FROM customers JOIN invoices ON customers.CustomerId = invoices.CustomerId

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

--10 Mostrar el nombre del cliente
-- nombre del artista de las canciones que ha comprado, 
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