# docker-deluge
deluge 1.3.15 on docker  
https://hub.docker.com/r/pilbbq/deluge

## Example:
```
docker run -v /tmp/deluge:/deluge -p 58847:58846 --user 1000 -t pilbbq/deluge
docker run -v /tmp/deluge:/deluge --network macvlan --user 1000 -t pilbbq/deluge
```

## Deluged remote access 
Remember to edit `/tmp/deluge/auth` (add a line like `admin:password:10`)  
And also change `/tmp/deluge/core.conf`, replace the `"allow_remote": false` with `"allow_remote": true`
