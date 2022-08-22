open Crypto

let response_cors res =
  Dream.respond
    ~headers:
      [
        ("Access-Control-Allow-Origin", "*");
        ( "Access-Control-Allow-Headers",
          "Origin, X-Requested-With, Content-Type, Accept" );
      ]
    res

let base58_encode request =
  Dream.param request "req" |> Base58.base58_encode |> Dream.respond

let base58_decode request =
  Dream.param request "req"
  |> Base58.base58_decode
  |> Option.get
  |> Dream.respond

let block_hash request =
  Dream.param request "req" |> Block_hash.block_hash_of_string |> Dream.respond

let blake2b_hash request =
  Dream.param request "req" |> Blake2B.blake2b_hash_of_string |> Dream.respond

let ed25519_secret_to_public request =
  Dream.param request "req" |> Ed25519.secret_to_public |> Dream.respond

let ed25519_sign request =
  Ed25519.sign
    (Dream.query request "sk" |> Option.get)
    (Dream.query request "msg" |> Option.get)
  |> Dream.respond

let ed25519_verify request =
  Ed25519.verify
    (Dream.query request "pk" |> Option.get)
    (Dream.query request "msg" |> Option.get)
    (Dream.query request "signature" |> Option.get)
  |> string_of_bool
  |> Dream.respond

let ed25519_public request =
  Ed25519.secret_to_public (Dream.query request "sk" |> Option.get)
  |> Dream.respond

(* let ed25519 request = *)
(*   Dream.param request "req" |> Blake2B.blake2b_hash_of_string |> Dream.respond *)

let health _request = "Service is up and running." |> Dream.respond

let start () =
  Dream.router
    [
      Dream.get "/base58/encode/:req" base58_encode;
      Dream.get "/base58/decode/:req" base58_decode;
      Dream.get "/block_hash/hash/:req" block_hash;
      Dream.get "/blake2b/hash/:req" blake2b_hash;
      Dream.get "/ed25519/secret_to_public/:req" ed25519_secret_to_public;
      Dream.get "/ed25519/sign" ed25519_sign;
      Dream.get "/ed25519/verify" ed25519_verify;
      Dream.get "/ed25519/public" ed25519_public;
      Dream.get "/health" health;
    ]
  |> Middlewares.cors_middleware
  |> Dream.logger
  |> Dream.run ~interface:"0.0.0.0" ~port:8080
