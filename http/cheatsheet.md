# curl HTTP cheat sheet

[online here](https://curl.github.io/curl-cheat-sheet/http-sheet.html)

| Verbose              | Hide progress           | extra info        | Write output     | Timeout
|----------------------|-------------------------|-------------------|------------------|--------------
| -v                   | -s                      | -w "format"       | -O               | -m <secs>
| --trace-ascii <file> |                         |                   | -o <file>        |
| **POST**             | **multipart**           | **PUT**           | **HEAD**         | **custom**
| -d "string"          | -F name=value           | -T <file>         | -I               | -X "METHOD"
| -d @file             | -F name=@file           |                   |                  |
| **Basic auth**       | **read cookies**        | **write cookies** | **send cookies** | **user-agent**
| -u user:password     | -b <file>               | -c <file>         | -b "c=1; d=2"    | -A "string"
| **Use proxy**        | **Headers, add/remove** | **follow redirs** | **gzip**         | **insecure**
| -x <host:port>       | -H "name: value"        | -L                | --compressed     | -k
|                      | -H "name:"              |                   |                  |

