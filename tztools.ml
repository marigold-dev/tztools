(* let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html *)

let test () =
  (* let block_hash = Tezos_crypto.Block_hash.of_string_exn "" in *)
  let hex =
    `Hex
      "0024b5ea0c7c05f5c1c6abab863bf9b863f715540babcbd399322ec3ef0ad0267f8e80176f0000000062930db004f7326e11c91f267c95c2babe578a10c0f3922e9be1eec03dc19badc3381e57c7000000210000000102000000040024b5ea0000000000000004ffffffff00000004000000005836158f2589e40b7b90734e8d9b5c564ebbd6c18a6a10adedc90c649828036c89e2159057457028f6d610ec4207dcbd6e81f7e6f4109a2e95458bad2266ea87000000006d9cfa3536f002000000529b6d1bdf2eec2d6361c4f4ac18ca374420eea39cef2acd2dc394d0d011105a7e39bf40a72d6df4b17e8395ad700db33441ba97297ea0c74b0a908ea0031700"
  in
  let binary = Hex.to_bytes hex in
  Dream.log "AAAA:%d" (Bytes.length binary);
  (* Dream.log "%s" (Hex.length hex) in *)
  (* let base58 = Tezos_crypto.Base58.raw_encode binary in
     Dream.log "%s" base58; *)
  (* let block_hash = Tezos_crypto.Block_metadata_hash.of_bytes_exn binary in *)
  (* let block_hash = Tezos_crypto.Block_hash.of_string_exn binary in *)
  (* let blake = Tezos_crypto.Blake2B.hash_bytes [binary] in *)
  let blake = Tezos_crypto.Block_hash.hash_bytes [binary] in
  (* let hex_result = Tezos_crypto.Blake2B.to_hex blake in *)
  (* let result = Tezos_crypto.Block_hash.to_string blake in *)
  (* Dream.log "BBBB:%d" (Bytes.length blake); *)
  (* let result = Tezos_crypto.Blake2B.to_string blake in *)
  (* let r = Hex.to_string hex in
     Dream.log "Client: %s" r; *)
  (* Tezos_crypto.Block_metadata_hash.to_string block_hash *)
  (* Tezos_crypto.Blake2B.raw_encode binary *)
  (* let abb = result |> Tezos_crypto.Base58.raw_encode in *)
  let r = Tezos_crypto.Block_hash.to_b58check blake in
  r
(* Tezos_crypto.Block_hash.to_string r *)
(* Tezos_crypto.Base58.check_encoded_prefix b58check_encoding "B" 51 *)
(* Hex.to_string hex_result *)

let block_hash_converter_of_string str =
  let hex = `Hex str in
  let binary = Hex.to_bytes hex in
  (* 32 bits here *)
  let blake = Tezos_crypto.Block_hash.hash_bytes [binary] in
  Tezos_crypto.Block_hash.to_b58check blake

(* let check_block_hash req_str =
   (* let hex = Hex.of_string req_str in *)
   (* let hash_result = Tezos_crypto.Block_hash.of_hex_opt hex in *)
   let hash_result = Tezos_crypto.Block_hash.of_string_opt req_str in
   match hash_result with
   | Some _ -> "Ok"
   | None -> "Error" *)

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> test () |> Dream.html);
         Dream.get "/base58/encode/:req" (fun request ->
             Dream.param request "req"
             |> Tezos_crypto.Base58.raw_encode
             |> Dream.html);
         Dream.get "/block_hash/check/:req" (fun request ->
             Dream.param request "req"
             |> block_hash_converter_of_string
             |> Dream.html);
       ]