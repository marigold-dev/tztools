# TzTools

# Development

## Setup an opam env

First, create a switch like so

```bash
opam switch create . 4.14.0 --no-install
```

Then you can run

```
opam install . --deps-only --with-test
```

and build the codebase with

```
dune build
```

Run test:

```
dune build @runtest --force --no-buffer
```
