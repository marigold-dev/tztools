let cors_middleware handler request =
  Lwt.map
    (fun response ->
      Dream.add_header response "Access-Control-Allow-Origin" "*";
      response)
    (handler request)
