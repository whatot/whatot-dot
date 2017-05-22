# Arch

Archlinux or Manjaro configuration

## Example Playbook

```
- hosts: servers
  roles:
      - role: arch
```

## Detailed description about some pkg

### perf and FlameGraph

* http://nanxiao.me/en/use-perf-and-flamegraph-to-profile-program-on-linux/
* https://github.com/brendangregg/FlameGraph

```
perf record --call-graph dwarf ./some-binary
perf report
perf script | stackcollapse-perf | flamegraph > perf.svg
```

1. `perf record` will generate a `perf.data`
2. `perf report` can parse it, then show the detailed of every function
3. `flamegraph` use the result of `perf` to generate the target `svg`

You can see the whole stack frameworks and functions’ consume time ratio.
