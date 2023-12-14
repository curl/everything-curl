# JavaScript and forms

A common mitigation against automated agents or scripts using curl is to have
the page with the HTML form use JavaScript to set values of some input fields,
usually one of the hidden ones. Often, there is some JavaScript code that
executes on page load or when the submit button is pressed which sets a magic
value that the server then can verify before it considers the submission to be
valid.

You can usually work around that by just reading the JavaScript code and
redoing that logic in your script. Using the tricks in
[Figure out what a browser sends](browsersends.md) to check exactly what a
browser sends is then also a good help.
