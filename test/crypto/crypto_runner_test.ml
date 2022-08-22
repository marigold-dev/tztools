let () =
  let open Alcotest in
  run "Tztools Crypto tests"
    [Ed25519_test.tests; Block_hash_test.tests; Blake2b_test.tests]
