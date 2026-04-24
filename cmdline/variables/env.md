# Environment variables

Import an environment variable with `--variable %VARNAME`. This import makes curl
exit with an error if the given environment variable is not set. A user can
also opt to set a default value if the environment variable does not exist,
using `=content` or `@file` as described above.

As an example, assign the `%USER` environment variable to a curl
variable and insert it into a URL. Because no default value is specified, this
operation fails if the environment variable does not exist:

    curl \
        --variable %USER \
        --expand-url "https://example.com/api/{{USER}}/method"

Instead, let's use `dummy` as a default value if `%USER` does not exist:

    curl \
        --variable %USER=dummy \
        --expand-url "https://example.com/api/{{USER}}/method"

Or get the default contents from a local file:

    curl \
        --variable %USER@file \
        --expand-url "https://example.com/api/{{USER}}/method"
