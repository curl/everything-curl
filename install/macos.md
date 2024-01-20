# macOS

macOS comes with the curl tool bundled with the operating system for many
years. If you want to upgrade to the latest version shipped by the curl
project, we recommend installing [homebrew](https://brew.sh/) (a macOS
software package manager) and then install the curl package from them:

    brew install curl
    
Note that when installing curl, brew does not create a `curl` symlink
in the default homebrew folder, to avoid clashes with the macOS version of curl.

Run the following to make brew curl the default one in your shell:

    echo 'export PATH="$(brew --prefix)/opt/curl/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc


## Get libcurl for macOS

When you install `curl` the tool with homebrew as described above, it also
installs libcurl together with its associated headers.

libcurl is also installed with macOS itself and always present, and if you
install the development environment `XCode` from Apple, you can use libcurl
directly without having to install anything extra as the curl include files
are bundled there.
