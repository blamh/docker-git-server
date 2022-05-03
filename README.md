# docker-git-server

Heavily based on https://github.com/jkarlosb/git-server-docker

## Basic Usage

How to run the container in port 2222 with two volumes: keys volume for public keys and repos volume for git repositories:

	$ docker run -d -p 2222:22 -v ~/git-server/keys:/git-server/keys -v ~/git-server/repos:/git-server/repos <docker image>

### How to use a public key:

	Copy them to keys folder:
	- From host: $ cp ~/.ssh/id_rsa.pub ~/git-server/keys
	- From remote: $ scp ~/.ssh/id_rsa.pub user@host:~/git-server/keys
	You need restart the container when keys are updated:
	$ docker restart <container-id>
	
### How to check that container works (you must to have a key):

	$ ssh git@<ip-docker-server> -p 2222
	...
	Welcome to git-server-docker! You've successfully authenticated, but I do not provide interactive shell access.
	...

### How to create a new repo:

	$ cd myrepo
	$ git init --shared=true
	$ git add .
	$ git commit -m "my first commit"
	$ cd ..
	$ git clone --bare myrepo myrepo.git

### How to upload a repo:

	From host:
	$ mv myrepo.git ~/git-server/repos
	From remote:
	$ scp -r myrepo.git user@host:~/git-server/repos

### How clone a repository:

	$ git clone ssh://git@<ip-docker-server>:2222/git-server/repos/myrepo.git
