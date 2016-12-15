

# How to run app in a develop mode?

- Install docker first
- `make buildCompose` - to build all the dependencie for the dev container
- `make compose` - to run the container. Check `docker ps` for ports and stuff in the other tab
	You should see a container `masstodon_api`, with ports `0.0.0.0:38500->80/tcp` and a name `masstodon_api_1`
- In the other terminal tab run make `make attachApp`
- When you are in a container (your mounted src folder):
	- run `yarn` to install all the project dependencies


# How to run app in a pre production?

- `make buildBase` - to install all the dependencies etc.
- `make buildFinal` - to wrap your app code into a docker image

Why not all at once? For build speed.

- `make composeProd` - to ran the same image that you want to push


# How to send that stuff to the cloud?

Login to docker cloud:
- docker login

Publish image to a registry:
- `make pushTest` or `make pushProd` - This will push the latest image with an appropriate tag

** pushing to test **

- `make pushTest` - this will launch an autoredeploy
