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


# Movies with 'the' word in the title
SELECT Title, Genre, Rating
FROM movies 
WHERE Title LIKE % the %;
 

# Movies with revenue above Average revenue
SELECT Title, Revenue
FROM movies
WHERE Revenue > ( SELECT AVG(Revenue) FROM movies );


# Movies with title cast and director
SELECT Title, Director, cast
FROM movies
WHERE Title = 'Soorarai Pottru'
GROUP BY Title;


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


# Release date of a particular movie
SELECT Title, 'Year'
FROM movies
WHERE Title = 'The Shawshank Redemption'; 


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


# Movies with specific director name
SELECT Director
FROM movies
WHERE Director = 'Christopher Nolan';


# Movies with specific actor name
SELECT Cast
FROM movies
WHERE Cast = 'Suriya';


# Difference between Avg. Rating of movies released before 2000 and after 2000
SELECT AVG(Before2000) - AVG(After2000)
FROM (
       SELECT AVG(Rating) AS 'avg'
	   FROM movies
	   WHERE 'Year' < '2000'
       GROUP BY Title
      ) AS Before2000,
      ( SELECT AVG(Rating) AS 'avg'
		FROM movies
        WHERE Year > '2000'
        GROUP BY Title
	  ) AS After2000;
      
      
# Directors who directed more than one movie 
SELECT Title, Director 
FROM movies
WHERE ( SELECT COUNT(*) FROM movies
        WHERE Director > 1
        ORDER BY Title, Director );
        

# Movies with highest average rating
SELECT Title, MAX(avg_rating) AS 'Rating'
FROM movies
WHERE ( SELECT AVG(Rating) AS avg_rating
        FROM movies
        GROUP BY Title );
        
        
# Movies with lowest average rating
SELECT Title, MIN(avg_rating) AS 'Rating'
FROM movies
WHERE ( SELECT AVG(Rating) AS avg_rating
        FROM movies
        GROUP BY Title );
        
        
# Director with movies which recieved highest rating
SELECT Director, Title, MAX(Rating) 
FROM movies
WHERE Director IS NOT NULL AND Rating IS NOT NULL
GROUP BY Director;


# Top 100 movies with a rating > 7.5
SELECT Title, 'Year', Rating
FROM movies
WHERE Rating > 7.5
ORDER BY Rating DESC
LIMIT 100;


# Top ten action movies with highest rating
SELECT Title, Genre, Rating
FROM movies 
WHERE Genre = 'Action'
ORDER BY Rating DESC
LIMIT 10;


# Movies with highest rating and less runtime
SELECT Title, Runtime, Rating
FROM movies
ORDER BY Rating DESC, Runtime ASC
LIMIT 100;


# Movies with highest rating starred by Leonardo di caprio
SELECT Title, Cast, Rating
FROM movies
WHERE Cast = 'Leonardo Di Caprio'
ORDER BY Rating DESC;


# Highest Grossing movie in a particular year
SELECT Title, Genre, 'Year', Revenue
FROM movies
WHERE 'Year' = '2020'
ORDER BY Revenue DESC;
