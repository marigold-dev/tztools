let greet who =
  let open Tyxml.Html in
  html
    (head (title (txt "Greeting")) [])
    (body [h1 [txt "Good morning, "; txt who; txt "!"]])

let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Dream.html (html_to_string (greet "world")));
         Dream.get "/echo/:word" (fun request ->
             Dream.html (Dream.param request "word"));
         Dream.get "/encode/:req" (fun request ->
             let param = Dream.param request "req" in
             Dream.html (Tezos_crypto.Base58.raw_encode param));
         Dream.get "/:word" (fun request ->
             Dream.param request "word" |> Template.render |> Dream.html);
         Dream.get "/vai/:word" (fun request ->
             Dream.param request "word"
             |> Layout.greet
             |> html_to_string
             |> Dream.html);
       ]
