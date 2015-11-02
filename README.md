Shiv is a opensource simple cmdb. Provides simple interface (web/api/cli) to store and search for host objects. 
====================================================

## <a name='toc'>Table of Contents</a>

  1. [Features](#features)
  1. [Installation ](#installation)
  1. [Screenshots ](#screenshots)
  1. [Contributors ](#contributors)



####[[⬆]](#toc) <a name='features'>Features:</a>

* Add 'host' objects and assign tags and traits to them
* Search for host objects
* CLI interface [shiv-cli](http://github.com/smeier00/shiv-cli)


####[[⬆]](#toc) <a name='installation'>Installation:</a>

```
apt-get install rubygems ruby build-essential git
git clone https://github.com/smeier00/shiv.git
cd shiv
bundle install
rake db:migrate
sudo script/rails server --port 80
```

####[[⬆]](#toc) <a name='screenshots'>Screenshots:</a>





####[[⬆]](#toc) <a name='contributors'>Contibutors:</a>
* Chris McEniry   (cmceniry@mit.edu)
* JD Bottorf      (jdbottorf@gmail.com)
* Brian Battistuz (bbattistuz@gmail.com)
* Doug Weimer     (dweimer@gmail.com)
