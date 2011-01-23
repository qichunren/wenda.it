# wenda.it is
 
+ a Q&A web application
+ a Rails3 + mysql application, and the "original repos":https://github.com/hideto/wenda.it used MongoDB.

### How to setup wenda.it dev environment

# Install Ruby
http://www.ruby-lang.org/en/downloads/

# Install Mysql
        in ubuntu
        sudo apt-get install mysql-server
        gem install mysql2  

# Install git
http://book.git-scm.com/2_installing_git.html

# Clone wenda.it project
        git://github.com/qichunren/wenda.it.git 

# Install required gems
        gem install bundler
        cd wenda.it
        bundle install
        rake db:create
        rake db:migrate
        rake db:seed
                
# Start rails server
cd wenda.it
rails server  
then visit http://localhost:3000
