let block_hash_converter_of_string str =
  let hex = `Hex str in
  let binary = Hex.to_bytes hex in
  let blake = Tezos_crypto.Block_hash.hash_bytes [binary] in
  Tezos_crypto.Block_hash.to_b58check blake
