FROM ocaml/opam:alpine AS build-opam
RUN sudo apk update && sudo apk upgrade
RUN sudo apk add gmp-dev libev-dev openssl-dev
COPY tztools.opam .
RUN opam install . --deps-only --locked 
COPY . .
RUN eval $(opam env) && sudo dune build tztools.exe
RUN sudo cp ./_build/default/tztools.exe /usr/bin/tztools.exe
# --- #
FROM alpine AS ocaml-app
COPY --from=build-opam /usr/bin/tztools.exe /home/app/tztools.exe
RUN apk update && apk upgrade
RUN apk add gmp-dev libev-dev openssl-dev
RUN adduser -D app
RUN chown app:app /home/app/tztools.exe
WORKDIR /home/app
USER app
EXPOSE 8080
ENTRYPOINT ["/home/app/tztools.exe"]