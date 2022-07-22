let blake2b_hash_of_string str =
  Hexstring.decode str |> fun result ->
  Result.get_ok result |> fun bytes ->
  Hacl_star.Hacl.Blake2b_32.hash bytes 32 |> Hexstring.encode
