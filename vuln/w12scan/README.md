docker ps a<br>
docker exec -it [w12scan-client] bash<br>
rm -rf /opt/w12scan-client/lib/loader.py<br>
rm -rf /opt/w12scan-client/data/api.json<br>
exit<br>
docker cp loader.py [w12scan-client]:/opt/w12scan-client/lib<br>
docker cp api.json [w12scan-client]:/opt/w12scan-client/data<br>
docker restart [w12scan-client]<br>
http://127.0.0.1:8000<br>
boyhack:boyhack
