let cors_middleware handler request =
  Lwt.map
    (fun response ->
      Dream.add_header response "Access-Control-Allow-Origin" "*";
      Dream.add_header response "Access-Control-Allow-Headers" "*";
      Dream.add_header response "Allow" "*";
      response)
    (handler request)
