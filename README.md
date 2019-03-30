# glibc_browser
glibc online code browser based on woboq

## how to use

```shell
docker run -d -p 8080:80 skysider/glibc_browser:<glibc_version>
```

visit `http://localhost:8080/public_html/glibc` , then you can search function definition or  something else with the search box on the left top corner.

![woboq.jpg](https://i.loli.net/2018/11/08/5be39506ba697.jpg)

## supported libc version
- 2.19
- 2.23
- 2.24
- 2.26
- 2.27
- 2.28
