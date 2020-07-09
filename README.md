# TransferBase GraphQL API

# Usage
  Add .env file and fill the vars values from the template file 
  .env.development

  Use docker to build and run the image:
    
  docker-compose up -d --build

  To prepare and seed the database with initial users and transfers on the runing docker container excute:
  
  rake db:migrate
  rake db:setup 

  The API is running on port 3000 by default
  

