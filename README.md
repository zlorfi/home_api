# build docker

`docker build --platform=linux/amd64 -t docker.io/zlorfi/home_api:latest .`

# push to registry

`docker push zlorfi/home_api:latest`

# setting ENVs

```
ENV['ELGATO_HOST'] = 'http://192.168.178.25:9123/elgato'
ENV['PIHOLE_HOST'] = 'https://192.168.178.11/admin'
ENV['PIHOLE_SECRET'] = '5ee3f5e50ba8e05bdf0565459c3c8669e24ca9c49'
ENV['WLED_HOST'] = 'http://192.168.178.110/json'
```
