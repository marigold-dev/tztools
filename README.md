# TzTools

# Development

## Setup an opam env

First, create a switch like so

```bash
opam switch create . 4.12.1 --no-install
```

Then you can run

```
opam install . --deps-only --with-test
```

and build the codebase with

```
dune build
```
