# Expand `--variable`

The `--variable` option itself can also be expanded, which allows you to
assign variables to the contents of other variables.

    curl \
        --expand-variable var1={{var2}} \
        --expand-variable fullname="Mrs {{first}} {{last}}" \
        --expand-variable source@{{filename}}

Or done in a config file:

    # Curl config file

    variable host=example

    expand-variable url=https://{{host}}.com

    expand-variable source@{{filename}}

