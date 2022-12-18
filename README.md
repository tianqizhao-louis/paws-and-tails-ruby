# Paws & Tails

*Bring Your New Best Friend Home.*

We are building a SAAS app that aims to connect pet finders and breeders together and improve the whole pet-finding business.

![](https://img.shields.io/badge/ruby-3.1.2-informational) ![](https://img.shields.io/badge/rails-7.0.4-informational)

![](https://img.shields.io/badge/coverage-100%25-brightgreen) ![](https://img.shields.io/badge/build-passing-green) ![](https://img.shields.io/badge/tests-288%20passed-red)


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Paws & Tails](#paws-tails)
  - [Team Members](#team-members)
  - [For the TA Team](#for-the-ta-team)
    - [Run the Project Locally in Docker (Recommended)](#run-the-project-locally-in-docker-recommended)
    - [Troubleshoot](#troubleshoot)
  - [Deployment](#deployment)

<!-- /code_chunk_output -->


## Team Members

    Tianqi Zhao (tz2529)
	Jiacheng Yin (jy3280)
	Dmitrii Zakharov (dz2428)

## For the TA Team

### Run the Project Locally in Docker (Recommended)

Our team dockerized the rails application so that there won't be any dependency, environment, or weird issues when the project is running on any machine.

We use ruby version `3.1.2` and rails version `7.0.4`, which is different from the class setup. But, if you are running it in docker, the version doesn't matter.

1. Download/make sure you have downloaded Docker

[https://www.docker.com/](https://www.docker.com/)

`docker-compose` is required to run the project. It should come with the installation of Docker. Run `docker-compose -v` to make sure you have it downloaded.

```bash
docker-compose -v                                 08:43:55 PM
>> Docker Compose version v2.12.1
```

2. **very important**! Get the `.env` file.

We have included an `.env` file in the Courework submission. I also include the `.env` file content in the submission comments.

Either download the `.env` file or copy-paste from the comment, put the file under `paws_and_tails/`.

Here is some helpful commands:

```bash 
cd paws_and_tails
touch .env
# paste what you have from the Coursework 
#   comments to the newly created .env file
```

Note that if you directly download the `.env` file from Coursework, it might be `env` rather than `.env`. You can either use terminal or you favorite editor (like VSCode) to change it from `env` to `.env`.

3. Build project docker image

Run `docker-compose build` to build the image.

```bash
docker-compose build
```

It takes some time to build the image. Feel free to let us know if any error occurs so we can solve it for you (there shouldn't be any error, though).

4. Run the project

Because we have used many Javascript functions for frontend, we heavily used `Selenium` to do the Cucumber testing. 

We use `selenium/standalone-firefox` to simulate all browser interactions, that means the `docker-compose` will pull a standalone Firefox down and connect with the project. 

*This process could take some time.*

```bash 
docker-compose up
```

Then, you have the project running! Go to `0.0.0.0:3000`

    Sidenote: our databases are running on AWS RDS,
    which has already been configured. so you don't 
    need to (and shouldn't) run db:migrate or db:seed.

5. Rspec and Cucumber Testing

Before running the tests, please make sure `docker-compose up` is running. Especially the `firefox` image must be up and running, because Cucumber use `Selenium` to talk to the simulated browser.

```bash
docker-compose up
```

- Run all tests at once

We use `guard` to automatically run all the testing and it will also listen to `app` changes and automatically rerun the test.

To run all the tests at once:

```bash 
docker-compose run --rm web bundle exec guard
```

Only run rspec:

```bash 
docker-compose run --rm web rails spec
```

Only run cucumber:

```bash 
docker-compose run --rm web rails cucumber
```

### Troubleshoot

If you run into the following issue:

```bash
strconv.Atoi: parsing "": invalid syntax
```

Just run this script:

```bash
sudo docker system prune
```

## Deployment

The app is deployed at: [https://paws-and-tails.herokuapp.com/](https://paws-and-tails.herokuapp.com/)