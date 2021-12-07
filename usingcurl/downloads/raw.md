# Raw

When `--raw` is used, it disables all internal HTTP decoding of content or
transfer encodings and instead makes curl passed on unaltered, raw, data.

This is typically used if you are writing a middle software and you want to
pass on the content to another HTTP client and allow that to do the decoding
instead.

