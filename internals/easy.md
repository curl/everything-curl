# Easy handles and connections

When reading the source code there are some useful basics that are good to
know and keep in mind:

 - 'data' is the variable name we use all over to refer to the easy handle
   (`struct Curl_easy`) for the transfer being worked on. No other name should
   be used for this and nothing else should use this name. The easy handle is
   the main object identifying a transfer. A transfer typically uses a
   connection at some point and typically only one at a time. There is a
   `data->conn` pointer that identifies the connection that is currently used
   by this transfer. A single connection can be used over time and even
   concurrently by several transfers (and thus easy handles) when multiplexed
   connections are used.

 - `conn` is the variable name we use all over the internals to refer to the
   current *connection* the code works on (`struct connectdata`).

 - `result` is the usual name we use for a `CURLcode` variable to hold the
   return values from functions and if that return value is different than
   zero, it is an error and the function should clean up and return (usually
   passing on the same error code to its parent function).
