 USE atharva;

SELECT * FROM movies;

# Movies with rating > 8
SELECT * FROM movies
WHERE Rating > 8;


# Distinct Genres 
SELECT DISTINCT Genre 
FROM movies;


# Movie released in specific year
SELECT Title, 'Year'
FROM movies 
WHERE 'Year' = 2023;


# Count of movies Genre wise
SELECT Genre, COUNT(*) AS movie_count
FROM movies
GROUP BY Genre;


# Avg. rating Director wise
SELECT Director, AVG(Rating) AS avg_rating
FROM movies
GROUP BY Director;


# Top rated movie
SELECT * FROM movies
ORDER BY Rating 
DESC LIMIT 1;


# Movies with revenue above Average revenue
SELECT Title, Revenue
FROM movies
WHERE Revenue > ( SELECT AVG(Revenue) FROM movies );


# Highest grossing movie Genre wise
SELECT Genre, Title, Revenue
FROM (
      SELECT Genre, Title, Revenue,
			 ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY Revenue DESC) AS row_num
      FROM movies
      ) RANKED WHERE row_num = 1;
      

# Avg. revenue / year certificate wise
SELECT 'Year', Certificate, AVG(Revenue) AS avg_revenue
FROM movies
GROUP BY Certificate;


# Movies with similar genre
SELECT Title, Genre
FROM movies
WHERE Genre LIKE '% Action %' OR Genre LIKE '% Adventure %';


# To get the Director, Cast names 
SELECT Title, Director, Cast 
FROM movies
WHERE Director IS NOT NULL AND Cast IS NOT NULL
GROUP BY Title;


#  Top Genres by Avg. revenue
SELECT Genre, AVG(Revenue) AS avg_revenue
FROM movies
GROUP BY Genre
ORDER BY avg_revenue DESC 
LIMIT 3;


# Directors who directed multiple genres
SELECT Director, COUNT( DISTINCT Genre ) AS num_genre_directed
FROM movies
GROUP BY Director
HAVING num_genre_directed > 1;


# Movies with rating above Avg. rating
SELECT Title, Rating 
FROM movies
WHERE Rating > ( SELECT AVG(Rating) 
				 FROM movies );
                 
                 
# Directors with movies released in a specific year
SELECT DISTINCT Director
FROM movies
WHERE 'Year' = ( SELECT MIN('Year') 
                 FROM movies);
                 
                 
# Movies similar to Cast members
SELECT Title, Cast
FROM movies
WHERE Cast IN ( SELECT Cast FROM movies );


# Avg. revenue per Director
SELECT Director, AVG(Revenue) AS avg_revenue
FROM movies 
GROUP BY Director;


# Combined runtime of movies genre wise
SELECT Genre, SUM(Runtime) AS combined_runtime
FROM movies
GROUP BY Genre;

      

