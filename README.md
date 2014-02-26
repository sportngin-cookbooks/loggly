# loggly cookbook
[![Build Status](https://travis-ci.org/sportngin-cookbooks/loggly.png)](https://travis-ci.org/sportngin-cookbooks/loggly)

# Usage
This coookbook is designed to be used in two ways

1. Purely through attributes

```ruby
node.default[:loggly] = {
  account: "your-loggly-account",
  token: "super-secret-loggly-token",
  port: 514,
  severity: "notice",
  files_to_monitor: [
    {
      tag: "nginx-access-log",
      path: "/var/log/nginx/access.log"
    },
    {
      tag: "nginx-error-log",
      path: "/var/log/nginx/error.log",
      severity: "error"
    }
  ]
}

```

2. Using the LWRP to monitor individual files

```ruby
  loggly_conf "my-log-file" do
    path "/path/to/my-log-file"
    tag "my-loggly-tag-to-search-for"
    port 514
    token "super-secret-loggly-token"
```

# Attributes
* account
* token
* port
* severity
* files_to_monitor


# Recipes
* default

# Author

Sport Ngin (<infrastructure@sportngin.com>)
