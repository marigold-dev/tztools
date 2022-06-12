(* let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html *)

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router
       [
         (* Dream.get "/" (fun _ -> test () |> Dream.html); *)
         Dream.get "/base58/encode/:req" (fun request ->
             Dream.param request "req" |> Lib.Base58.base58_encode |> Dream.html);
         Dream.get "/base58/decode/:req" (fun request ->
             Dream.param request "req"
             |> Lib.Base58.base58_decode
             |> Option.get
             |> Dream.html);
         Dream.get "/block_hash/hash/:req" (fun request ->
             Dream.param request "req"
             |> Lib.Block_hash.block_hash_of_string
             |> Dream.html);
         Dream.get "/blake2b/hash/:req" (fun request ->
             Dream.param request "req"
             |> Lib.Blake2B.blake2b_hash_of_string
             |> Dream.html);
       ]
