# JSON

curl 7.82.0 introduced the `--json` option as a new way to send JSON formatted
data to HTTP servers using POST. This option works as a shortcut and provides
a single option that replaces these three:

    --data [arg]
    --header "Content-Type: application/json"
    --header "Accept: application/json"

This option doesn't make curl actually understand or know about the JSON data
it sends, but it makes it easer to send it. curl will not touch or parse the
data that it sends, so you need to make sure it is valid JSON yourself.

Send a very basic JSON object to a server:

    curl --json '{"tool": "curl"}' https://example.com/

Send JSON from a local file:

    curl --json @json.txt https://example.com/
    
Send JSON passed to curl on stdin:
    
    echo '{"a":"b"}' | curl --json @- https://example.com/

You can use multiple `--json` options on the same command line. This makes
curl concatenate the contents from the options and send all data in one go to
the server. Note that the concatenation is plain text based and will not in
any way merge the JSON object as per JSON.

Send JSON from a file and concatenate a string to the end:

    curl --json @json.txt --json ", "end": "true"}' https://example.com/
