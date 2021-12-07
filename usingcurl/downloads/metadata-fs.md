# Storing metadata in file system

When saving a download to a file with curl, the `--xattr` option tells curl to
also store certain file metadata in "extended file attributes". These extended
attributes are standardized name/value pairs stored in the file system,
assuming one of the supported file systems and operating systems are used.

Currently, the URL is stored in the `xdg.origin.url` attribute and, for HTTP,
the content type is stored in the `mime_type` attribute. If the file system
does not support extended attributes when this option is set, a warning is
issued.
