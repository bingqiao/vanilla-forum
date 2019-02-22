## Single Docker Container for Vanilla Forum
This project builds a single docker container for Vanilla Forum for testing purpose.
You can try this out by either pulling a prebuilt image from dockerhub or build the image yourself.

### Pull from dockerhub and run
1. pull docker image
```
docker pull bqiaodev/vanilla-forum
```
2. create and run container
```
docker run -p 80:80 -p 3306:3306 -dit --name vf-container bqiaodev/vanilla-forum
```

### Checkout github project and build locally
1. build docker image
```
./build vf
```
2. create and run container
```
./run vf vf-container
```

### Once up and running, go to `localhost` in browser and setup Vanilla Forum with following values
- dbhost: localhost
- db: vanilla_data
- dbuser: vanilla_user
- dbpassword: letmein

Choose any value for admin user setup.
