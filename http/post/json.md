# JSON

curl 7.82.0 introduced the `--json` option as a new way to send JSON formatted
data to HTTP servers using POST. This option works as a shortcut and provides
a single option that replaces these three:

    --data [arg]
    --header "Content-Type: application/json"
    --header "Accept: application/json"

This option does not make curl actually understand or know about the JSON data
it sends, but it makes it easier to send it. curl does not touch or parse the
data that it sends, so you need to make sure it is valid JSON yourself.

Send a basic JSON object to a server:

    curl --json '{"tool": "curl"}' https://example.com/

Send JSON from a local file:

    curl --json @json.txt https://example.com/
    
Send JSON passed to curl on stdin:
    
    echo '{"a":"b"}' | curl --json @- https://example.com/

You can use multiple `--json` options on the same command line. This makes
curl concatenate the contents from the options and send all data in one go to
the server. Note that the concatenation is plain text based and it does not
merge the JSON objects as per JSON.

Send JSON from a file and concatenate a string to the end:

    curl --json @json.txt --json ', "end": "true"}' https://example.com/

## Crafting JSON to send

The quotes used in JSON data sometimes makes it a bit difficult and cumbersome
to write and use in shells and scripts.

Using a separate tool for this purpose might make things easier for you, and
one tool in particular that might help you accomplish this is [jo](https://github.com/jpmens/jo).

Send a basic JSON object to a server with jo and `--json`

    jo -p name=jo n=17 parser=false | curl --json @- https://example.com/

## Receiving JSON

curl itself does not know or understand the contents it sends or receives,
including when the server returns JSON in its response.

Using a separate tool for the purpose of parsing or pretty-printing JSON
responses might make things easier for you, and one tool in particular that
might help you accomplish this is [jq](https://stedolan.github.io/jq/).

Send a basic JSON object to a server, and pretty-print the JSON response:

    curl --json '{"tool": "curl"}' https://example.com/ | jq

Send the JSON with `jo`, print the response with `jq`:

    jo -p name=jo n=17 | curl --json @- https://example.com/ | jq

jq is a powerful and capable tool for extracting, filtering and managing JSON
content that goes way beyond just pretty-printing.
