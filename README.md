```
docker rm custom-wsl
docker build --build-arg USER=devla -t custom-wsl .
docker run --name custom-wsl custom-wsl
docker export --output="custom-wsl.tar.gz" custom-wsl
```