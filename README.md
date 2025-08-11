Open up docker-compose.yaml and change the mapping port from 8080 to something else like 8081...
Change the MySQL database name, user name, and both passwords !

Run this after wordpress folder is populated:

```sh
sudo chown -R www-data:www-data /opt/nikatrnik.sk/wordpress
sudo find /opt/nikatrnik.sk/wordpress -type d -exec chmod 755 {} \;
sudo find /opt/nikatrnik.sk/wordpress -type f -exec chmod 644 {} \;
```
