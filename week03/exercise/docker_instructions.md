To start up the MySQL container and login

        docker run -d --name wk03ex mysql:5
        docker exec -it wk03ex bash

At the command line

        mysql -u root -p

Enter `crud` for the password

Then do the exercise. When you are done type `exit` to quit MySQL, and then `exit` again to quit the container.

Then stop the MySQL container from running.

        docker stop wk03ex

If you want to start it up again type

        docker start wk03ex
        docker exec -it wk03ex bash

And login to MySQL again.