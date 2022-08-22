open Crypto

let test_blake2b () =
  let expected =
    "b2e06daa2bdd6616cd1d66e739a112353e5192a134684706454d0db6382e0161" in
  let case = "1231" in
  Alcotest.(check string) "" expected (Blake2B.blake2b_hash_of_string case)

let tests =
  let open Alcotest in
  ("Blake2b", [test_case "converter_of_string" `Quick test_blake2b])
