# Get curl for macOS

macOS comes with the curl tool bundled with the operating system since many
years. If you want to upgrade to the latest version shipped by the curl
project, we recommend installing [homebrew](https://brew.sh/) (a macOS
software package manager) and then install the curl package from them:

    brew install curl
    
Note however that when installing curl, brew does not create a `curl` symlink
in the default homebrew folder, to avoid clashes with the macOS version of curl.

Check the output of the command above, which should give you a command to execute
to make brew curl the default one in your shell, depending on your homebrew prefix
(for example, on Apple silicon, you'd have to run `echo 'export PATH="/opt/homebrew/opt/curl/bin:$PATH"' >> ~/.zshrc`).


## Get libcurl for macOS

When you install `curl` the tool with homebrew as described above, it also
installs libcurl together with its associated headers.

libcurl is also installed with macOS itself and always present, and if you
install the development environment `XCode` from Apple, you can use libcurl
directly without having to install anything extra as the curl include files
are bundled there.
