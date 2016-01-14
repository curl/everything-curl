## HTTP multipart formposts

A multipart formpost is what an HTTP client sends when an HTML form is
submitted with *enctype* set to "multipart/form-data".

It is an HTTP POST request sent with the request body specially formatted as a
series of "parts", separated with MIME boundaries.

An example piece of HTML would look like this

    <form action="submit.cgi" method="post" enctype="multipart/form-data">
       Name: <input type="text" name="person"><br>
       File: <input type="file" name="secret"><br>
       <input type="submit" value="Submit">
    </form> 

Which could looks something like this in a web browser

![a multipart form](multipart-form.png)

A user can fill in text in the 'Name' field and by pressing the 'Browse'
button a local file can be selected that will be uploaded when 'Submit' is
pressed.

### The HTTP this generates

TBD

### Converting an HTML form

TBD
