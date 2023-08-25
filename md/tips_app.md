fiddler

https://www.xyaz.cn/

http://slproweb.com/products/Win32OpenSSL.html

openssl x509 -subject_hash_old -in FiddlerRoot.cer

e5c3944b.0

/system/etc/security/cacerts/

Read-only file system

mount -o remount,rw /system

chmod 777 e5c3944b.0

mount -o remount,ro /system

Settings -> Security -> Trusted credentials -> SYSTEM -> DO_NOT_TRUST_BC

burpsuite + fiddler:

fiddler getway proxy add 127.0.0.1:8080