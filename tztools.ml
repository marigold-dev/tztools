let response_cors res =
  Dream.respond
    ~headers:
      [
        ("Access-Control-Allow-Origin", "*");
        ( "Access-Control-Allow-Headers",
          "Origin, X-Requested-With, Content-Type, Accept" );
      ]
    res

let () =
  Dream.run ~interface:"0.0.0.0" ~port:8080
  @@ Dream.logger
  @@ Dream.router
       [
         Dream.scope "/" []
           [
             Dream.get "/base58/encode/:req" (fun request ->
                 Dream.param request "req"
                 |> Lib.Base58.base58_encode
                 |> response_cors);
             Dream.get "/base58/decode/:req" (fun request ->
                 Dream.param request "req"
                 |> Lib.Base58.base58_decode
                 |> Option.get
                 |> response_cors);
             Dream.get "/block_hash/hash/:req" (fun request ->
                 Dream.param request "req"
                 |> Lib.Block_hash.block_hash_of_string
                 |> response_cors);
             Dream.get "/blake2b/hash/:req" (fun request ->
                 Dream.param request "req"
                 |> Lib.Blake2B.blake2b_hash_of_string
                 |> response_cors);
             Dream.get "/health" (fun _ ->
                 "Service is up and running." |> response_cors);
           ];
       ]
