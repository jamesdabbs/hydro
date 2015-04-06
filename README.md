# Hydro

Packages a few simple utilities for cycling data up and down from the cloud

## Installation and Configuration

Install with `gem install hydro`

Expects a configuration file in `/etc/hydro/config.yml`

```yml
---
s3: {
  id:     ...,
  key:    ...,
  bucket: ...
},
log: ...,
rules: [
  { to: ..., ext: ... }
]
```

## Usage

`evaporate [file]` - uploads file to bucket
`precipitate` - downloads and sorts files from bucket
`precipitated [start|stop|...]` - daemon version of `precipitate`

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hydro/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
