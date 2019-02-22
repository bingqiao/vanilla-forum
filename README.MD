1. download vanilla forum zip (vanilla-core-2.8) and place it in `binaries/vanilla/`
2. build docker image
```
./build vf
```
3. create and run container
```
./run vf vf-container
```
4. create database
```
./exec vf-container
```
5. Go to `localhost` in browser and setup vanilla forum with following values
- dbhost: localhost
- db: vanilla_data
- dbuser: vanilla_user
- dbpassword: letmein

