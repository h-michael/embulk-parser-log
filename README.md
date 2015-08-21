# Ltsv parser plugin for Embulk

TODO: Write short description here and embulk-parser-ltsv.gemspec file.

## Overview

* **Plugin type**: parser
* **Guess supported**: no

## Configuration

- columns: description (array, required)

## Example
If you have apache logs that format is 'ltsv' like this,
```domain:example.com/t/tident:-/tuser:-/ttime:21/Aug/2015:10:57:01 +0900/tprotocol:HTTP/1.1/tstatus:200/tsize:62443/treferer:-/t```

```yaml
in:
  type: any file input plugin type
  parser:
    type: ltsv
    columns:
    - {name: domain ,type: string}
    - {name: ident ,type: string}
    - {name: user, type: string}
    - {name: time ,type: timestamp, format: '%d/%b/%Y:%H:%M:%S %z'}
    - {name: protocol ,type: string}
    - {name: status ,type: string}
    - {name: size ,type: long}
    - {name: referer ,type: string}
exec: {}
out: {type: stdout}
```


```
$ embulk gem install embulk-parser-ltsv
```

## Build

```
$ rake
```
