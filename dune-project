(lang dune 3.2)

(name tztools)

(version 0.1)

(maintainers "contact@marigold.dev")

(generate_opam_files true)

(package
 (name tztools)
 (synopsis "TzTools")
 (description "TzTool")
 (depends
  (alcotest :with-test)
  (dune
   (and
    :build
    (>= 3.1.1)))
  (dream
   (= 1.0.0~alpha4))
  tyxml
  tezos-hacl-glue
  tezos-hacl-glue-unix
  tezos-crypto
  hexstring))

(package
 (name dev)
 (synopsis "A package to install dev dependencies")
 (description "THIS PACKAGE IS FOR DEVELOPMENT PURPOSE")
 (allow_empty)
 (depends
  (ocamlformat
   (>= 0.20))
  (ocamlformat-rpc
   (>= 0.19))
  (ocaml-lsp-server
   (>= 1.10.3))))
