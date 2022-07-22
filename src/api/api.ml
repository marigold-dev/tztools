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

let health _request = "Service is up and running." |> Dream.respond

let start () =
  Dream.run ~interface:"0.0.0.0" ~port:8080
  @@ Dream.logger
  @@ Middlewares.cors_middleware
  @@ Dream.router
       [
         Dream.get "/base58/encode/:req" base58_encode;
         Dream.get "/base58/decode/:req" base58_decode;
         Dream.get "/block_hash/hash/:req" block_hash;
         Dream.get "/blake2b/hash/:req" blake2b_hash;
         Dream.get "/health" health;
       ]
