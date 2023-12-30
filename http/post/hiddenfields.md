# Hidden form fields

Sending a post with `-d` is the equivalent of what a browser does when an HTML
form is filled in and submitted.

Submitting such forms is a common operation with curl; effectively, to have
curl fill in a web form in an automated fashion.

If you want to submit a form with curl and make it look as if it has been done
with a browser, it is important to provide all the input fields from the
form. A common method for webpages is to set a few hidden input fields to the
form and have them assigned values directly in the HTML. A successful form
submission, of course, also includes those fields and in order to do that
automatically you may be forced to first download the HTML page that holds the
form, parse it, and extract the hidden field values so that you can send them
off with curl.
