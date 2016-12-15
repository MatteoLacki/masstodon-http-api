run: ## run the app
	- coffee src/index.coffee

buildCompose: ## Build / download docker images for compose DEV
	- docker-compose -f docker-compose-dev.yml build

compose: ## Start masstodon DEV containers
	- docker-compose -f docker-compose-dev.yml -p masstodon up

composeProd: ## Start masstodon PROD containers
	- docker-compose -f docker-compose-prod.yml -p masstodon up

buildBase: ## Build base getty base dev image
	- docker build -t masstodon-base --no-cache -f dockerfiles/prod-1-dependencies .

buildFinal: ## Build release version image
	- docker build -t masstodon-api:latest -f dockerfiles/prod-2-app .

pushTest: ## Push the latest test release of a prod Image
	- @echo 'Pushing as TEST. Are you sure? 3 seconds to abort. WILL AUTOREDEPLOY'
	- sleep 3


	- docker tag masstodon-api:latest matteolacki/masstodon-api:latest
	- docker tag masstodon-api:latest matteolacki/masstodon-api:test
	- docker tag masstodon-api:latest matteolacki/masstodon-api:`date +"%b-%d"`-test

	- @echo 'pushing as latest'
	- docker push matteolacki/masstodon-api:`date +"%b-%d"`-test
	- docker push matteolacki/masstodon-api:latest

	- @echo 'Pushing with a test tag. WILL AUTOREDEPLOY!!! 5 seconds to abort'
	- sleep 5
	- docker push matteolacki/masstodon-api:test
	- @echo 'Done. There is no going back now'

pushProduction: ## Push the latest production release of a prod Image
	- @echo 'Pushing as PRODUCTION. Are you sure? 8 seconds to abort'
	- sleep 8

	- docker tag masstodon:latest matteolacki/masstodon-api:`date +"%b-%d"`-production
	- docker tag masstodon:latest matteolacki/masstodon-api:latest

	- docker push matteolacki/masstodon-api:`date +"%b-%d"`-production
	- @echo 'pushing as latest'
	- docker push matteolacki/masstodon-api:latest

	- @echo 'Done. There is no going back now'

attachApp: ## Attach to a backend
	- docker exec --interactive --tty masstodon_api_1 /bin/bash


mongoAttach: ## Attach to getty Mongo instance
	- docker exec --interactive --tty masstodon_mongodb_1 /bin/bash

# Scripts
.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
