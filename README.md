## Persisting using auto_run.sh

```sh
ubiattach -m 6 -d 2
/bin/mount -t ubifs ubi2:config /tmp/config
vi /tmp/config/autorun.sh
chmod +x /tmp/config/autorun.sh
echo .
echo "unmounting /tmp/config..."
umount /tmp/config
ubidetach -m 6
```
