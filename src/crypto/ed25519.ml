let sign sk msg =
  let sk = Hexstring.decode sk |> Result.get_ok in
  let msg = Bytes.of_string msg in
  Hacl_star.Hacl.Ed25519.sign ~sk ~msg |> Hexstring.encode

let verify edsk msg edsign =
  let pk = Hexstring.decode edsk |> Result.get_ok in
  let msg = Bytes.of_string msg in
  let signature = Hexstring.decode edsign |> Result.get_ok in
  Hacl_star.Hacl.Ed25519.verify ~pk ~msg ~signature

let secret_to_public edsk  =
  let sk = Hexstring.decode edsk |> Result.get_ok in
  Hacl_star.Hacl.Ed25519.secret_to_public ~sk |> Hexstring.encode

