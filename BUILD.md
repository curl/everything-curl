# Build the book

## Prerequisites

Download and install [mdBook](https://github.com/rust-lang/mdBook).

## Install

In an empty directory, create a subdirectory called `book` or make a symlink
named `book` pointing out the target directory in which you want to render the
book. The target directory works fine as a root directory for a local web
server.

Create a symlink called `src` that points to the source directory of the book.

Create a file called `book.toml` with the contents shown below.

## Build it

`mdbook build`

This makes the complete version of the book in HTML, PDF and ePUB formats. The
target directory gets updated.

## `book.toml`

~~~
[book]
authors = ["Daniel Stenberg"]
language = "en"
multilingual = false
src = "src"
title = "everything curl"

[output.html.fold]
enable = true     # whether or not to enable section folding
level = 0         # the depth to start folding
~~~
