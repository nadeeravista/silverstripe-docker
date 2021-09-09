### Step 1 - Give the the following permission
Composer runtime is located in the host file system and volume mounted for the container. Host file need permission for 
running composer command inside the container

Give he the following permission for the bin/composer  
``chmod -R 777 bin/composer``

## Step 2 - Change the Code volume mount 
Change the following location in ``docker-compose.yml`` that you need to have the silverstipe code
``` 
volumes:
      - /Users/nad/workspace/silverstripe-code:/var/www/html
      - ./bin/composer:/usr/local/bin/composer
  ```

## Step 3 - Optional(first time only) Create silverstripe project inside docker container
``docker-compose exec -w /var/www/html web composer create-project silverstripe/installer .``

## Step 4 - Optional, Do if you already have a Silverstripe project
``docker-compose exec -w /var/www/html web composer install``

## Step 5  
- Create .env file  
``mv .env.example .env``
- Change content as per the database settings in the .env file

## Step 6. 
``localhost:8080/public``
    
## See dev options. 
http://localhost:8080/dev/
