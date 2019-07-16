# pr-tool

- [x] List PR's
- [x] Count PR's


#### Install

```bash
brew tap fordpass/homebrew-tap git@github.ford.com:fordpass/homebrew-tap.git
```

```bash
brew install pr-tool
```

#### Arguments:
    -s [--server] (optional) Enterprise github server URL Ex.:https://github.example.com/api/v3/
    -t [--token] Personal access token
    -u [--user] User name
    -o [--org] Organization
    -r [--repo] Repo
    -a [--action] [print|count] (print is default)
    --verbose Print degub information
    --help This info


#### Use:

`pr-count [-s server] -t b27a8...500d -u rafiki270 -o einstore -r speedster`
