open Crypto

let sign () =
  let expected =
    "6dd355667fae4eb43c6e0ab92e870edb2de0a88cae12dbd8591507f584fe4912babff497f1b8edf9567d2483d54ddc6459bea7855281b7a246a609e3001a4e08"
  in
  let sk = "1498b5467a63dffa2dc9d9e069caf075d16fc33fdd4c3b01bfadae6433767d93" in
  let msg = "Message for Ed25519 signing" in
  Alcotest.(check string) "same string" expected (Ed25519.sign sk msg)

let verify () =
  let expected = true in
  let pk = "b7a3c12dc0c8c748ab07525b701122b88bd78f600c76342d27f25e5f92444cde" in
  let msg = "Message for Ed25519 signing" in
  let sign =
    "6dd355667fae4eb43c6e0ab92e870edb2de0a88cae12dbd8591507f584fe4912babff497f1b8edf9567d2483d54ddc6459bea7855281b7a246a609e3001a4e08"
  in
  Alcotest.(check bool) "same bool" expected (Ed25519.verify pk msg sign)

let secret_to_public () =
  let expected =
    "b7a3c12dc0c8c748ab07525b701122b88bd78f600c76342d27f25e5f92444cde" in
  let sk = "1498b5467a63dffa2dc9d9e069caf075d16fc33fdd4c3b01bfadae6433767d93" in
  Alcotest.(check string) "same string" expected (Ed25519.secret_to_public sk)

let tests =
  let open Alcotest in
  ( "Ed25519",
    [
      test_case "Get a signature from a secret key with a message." `Quick sign;
      test_case "Verify if a public key + message + signature is valid" `Quick
        verify;
      test_case "Get a public key from a secret key" `Quick secret_to_public;
    ] )
