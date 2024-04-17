# Project 1 SQL 
#
# Business model Customer to Customer (C2C) allows customers to do business with each other.
# This model is growing fast with e-commerce platforms where sellers may be required to pay some amount and buyer can buy it without paying anything. 
# E-Commerce website brings the seller and buyer to the same platform. 
# Analyzing the user's database will lead to understanding the business perspective. Behaviour of the users can be traced in terms of business with exploration of the user’s database. 

# Dataset: One .csv file with name users_data with 98913 rows and 24 columns
# Tasks to be  performed : 


# 1.Create new schema as ecommerce

CREATE DATABASE ecommerce ; 
USE ecommerce;

# 2.Import .csv file users_data into MySQL
         -- (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file ->
         -- Next -> choose options : Create a new table , select delete if exist -> next -> next)
 
-- csv file link :-  https://drive.google.com/file/d/1B0VPuWv3dmOJFWOsdBSND7ZPZxaVocA3/view?usp=sharing

USE ecommerce;
SELECT COUNT(*) Num_of_Rows FROM users_data;

 -- total Rows = 98913 in user_data csv file

 
 
 # 3. Run SQL command to see the structure of table
 
 DESC users_data;
 #OR
 DESCRIBE users_data;
 
 
 # 4.Run SQL command to select first 100 rows of the database
 
SELECT * FROM users_data
LIMIT 100;
 
 
 # 5. How many distinct values exist in table for field country and language
  
SELECT 
    COUNT(DISTINCT country) country_count,
    COUNT(DISTINCT language) language_count
FROM users_data;

-- Total 200 Unique Country and 5 Unique Languages are used.
 
 
 # 6. Check whether male users are having maximum followers or female users.
 
SELECT gender, SUM(socialNbFollowers) followers FROM users_data
GROUP BY gender
ORDER BY followers DESC
LIMIT 1;  # set limit 2 to check both gender followers
 
   -- Female users are having maximum followers which is 262,458
   -- while male user are having only 77,038
 
 
 
 # 7.Calculate the total users those
      -- a. Uses Profile Picture in their Profile  
         
SELECT COUNT(hasProfilePicture) FROM users_data
WHERE hasProfilePicture = 'True';
               
	  # -- 97,018 number of users have profile picture
    
	  -- b. Uses Application for Ecommerce platform
    
SELECT COUNT(hasAnyApp) FROM users_data
WHERE hasAnyApp = 'True';
    
      # -- 26,174 users have used Application for Ecommerce platform
    
    
      -- c. Uses Android app
      
SELECT COUNT(hasAndroidApp) FROM users_data
WHERE hasAndroidApp = 'True';
      
      -- Only 4,819 users has Android app for ecommerce platform
     
     
      -- d. Uses ios app
      
SELECT COUNT(hasIosApp) FROM users_data
WHERE hasIosApp = 'True';
    
      # -- 21,527 users uses IOS App
    
    
# 8. Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers.
       --  (Hint: consider only those users having at least 1 product bought.)
       
SELECT  country, COUNT(productsBought) no_of_buyers FROM users_data
GROUP BY country
ORDER BY no_of_buyers DESC;
 
       -- France has highest no. of buyers = 25,135
 
 
# 9. Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers.
       -- (Hint: consider only those users having at least 1 product sold.)
  
SELECT country, COUNT(productsSold) no_of_sellers FROM users_data
GROUP BY country
HAVING COUNT(productsSold) >= 1
ORDER BY no_of_sellers ASC;
 
 
 
# 10. Display name of top 10 countries having maximum products pass rate.

SELECT country FROM users_data
GROUP BY country
HAVING MAX(productsPassRate)
LIMIT 10;

# or with products_PassRate
SELECT country , MAX(productsPassRate) products_PassRate FROM users_data GROUP BY country HAVING  MAX(productsPassRate)  LIMIT 10 ;



# 11. Calculate the number of users on an ecommerce platform for different language choices.

SELECT language, COUNT(type) no_of_users FROM users_data
GROUP BY language;

    # -- en (English) language having the most numbers of users --> 51,564
    # -- es (Spainish) language having the least numbers of users --> 6,033

# 12. Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform.
       --  (Hint: use UNION to answer this question.)
       
       
       
SELECT 'products_Wished' types, COUNT(productsWished) count FROM users_data
WHERE gender = 'F' 
UNION 
SELECT  'socialProducts_Liked' types, COUNT(socialProductsLiked) count FROM users_data
WHERE gender = 'F';

     # -- both having the same numbers of female users --> 76,121


 
# 13. Check the choice of male users about being seller or buyer. 
       -- (Hint: use UNION to solve this question.)

SELECT  'seller' types, COUNT(productsSold) count FROM users_data
WHERE gender = 'M' 
UNION 
SELECT 'buyer' types, COUNT(productsBought) count FROM users_data
WHERE gender = 'M';
    
    # -- same numbers of buyers and sellers --> 22,792
 
 
 
# 14. Which country is having maximum number of buyers?

SELECT country , MAX(productsBought) max_buyers FROM users_data 
GROUP BY country 
ORDER BY max_buyers DESC 
LIMIT 1 ;

    # -- Belgique country has the maximum buyers --> 405


# 15. List the name of 10 countries having zero number of sellers.

SELECT country   FROM users_data 
WHERE productsSold = 0
GROUP BY country 
ORDER BY productsSold DESC LIMIT 10 ;




# 16. Display record of top 110 users who have used ecommerce platform recently.

SELECT *  FROM users_data 
GROUP BY daysSinceLastLogin
HAVING MIN(daysSinceLastLogin)  
LIMIT 110 ;

   # -- Min num_days Since Last Login --> 11

# 17. Calculate the number of female users those who have not logged in since last 100 days.


SELECT  COUNT(type) Female_Not_Login_Since_100_days FROM users_data 
WHERE    daysSinceLastLogin > 100   AND    gender = 'F' 
GROUP BY   gender ;

    # --  70,189 female users   have not logged in since last 100 days.



# 18. Display the number of female users of each country at ecommerce platform.


SELECT country , COUNT(gender) no_of_female_users FROM users_data  
WHERE gender = 'F'
GROUP BY country 
ORDER BY no_of_female_users DESC ;

	# -- France has the highest numbers of Female users
     
     
# 19. Display the number of male users of each country at ecommerce platform.

SELECT country , COUNT(type) male_users FROM users_data
WHERE gender = 'M' 
GROUP BY country 
ORDER BY male_users DESC ;

    # -- France has the highest numbers of male users


# 20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

SELECT country , AVG(productsSold) AVG_PRODUCT_SOLD , AVG(productsBought) AVG_PRODUCT_BOUGHT FROM users_data
WHERE gender = 'M' 
GROUP BY country ;

 
 