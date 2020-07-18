  ### server

* -k: Secret key
* -p: 8888, UDP port
* -l: limit conn

```yaml
version: '3.0'

services:
  dragonite-server:
    image: clibing/alpine-dragonite
    # container_name: dragonite-server
    restart: always
    # network_mode: host
    # ports:
    #   - "8888:8888"
    command: "proxy -s -k abc123. -p 8888 -l 100"
```

### client

* server.ip: server ip
* -p: 8888, UDP port
* -k: Secret key
* -x: socks5 port
* socks5: endpoint 11153

```yaml
version: '2.0'

services:
  dragonite-client:
    image: clibing/alpine-dragonite
    # container_name: dragonite-client
    restart: always
    ports:
      - "11152:152"
      - "11153:153"
      - "11156:156"
    command: "proxy -a server.ip -p 8888 -k abc123. -d 100 -u 10 -x 153"
```

### other

* [github.com dragonite-java](https://github.com/dragonite-network/dragonite-java)