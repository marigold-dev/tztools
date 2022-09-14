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

let ed25519_secret_to_public request =
  Dream.param request "req" |> Ed25519.secret_to_public |> Dream.respond

let ed25519_sign request =
  Ed25519.sign
    (Dream.query request "sk" |> Option.get)
    (Dream.query request "msg" |> Option.get)
  |> Dream.respond

let ed25519_verify request =
  Ed25519.verify
    (Dream.query request "pk" |> Option.get)
    (Dream.query request "msg" |> Option.get)
    (Dream.query request "signature" |> Option.get)
  |> string_of_bool
  |> Dream.respond

let ed25519_public request =
  Ed25519.secret_to_public (Dream.query request "sk" |> Option.get)
  |> Dream.respond

(* let ed25519 request = *)
(*   Dream.param request "req" |> Blake2B.blake2b_hash_of_string |> Dream.respond *)

let health _request = "Service is up and running." |> Dream.respond

module Config = struct
  type app = Dream.handler
  type route = Dream.route
  type handler = Dream.handler

  let json_path = "/openapi.json"
  let doc_path = "/docs"

  let json_route json = Dream.get json_path (fun _ -> Dream.json json)

  let doc_route html = Dream.get doc_path (fun _ -> Dream.html html)

  let get = Dream.get
  let post = Dream.post
  let delete = Dream.delete
  let put = Dream.put
  let options = Dream.options
  let head = Dream.head
  let patch = Dream.patch

  let build_routes = Dream.router
end

module OpenRouter = Openapi_router.Make (Config)

let start () =
  OpenRouter.empty
  |> OpenRouter.description "Tezos libraries as an api"
  |> OpenRouter.get "/base58/encode/:req" base58_encode
  |> OpenRouter.get "/base58/decode/:req" base58_decode
  |> OpenRouter.get "/block_hash/hash/:req" block_hash
  |> OpenRouter.get "/blake2b/hash/:req" blake2b_hash
  |> OpenRouter.get "/ed25519/secret_to_public/:req" ed25519_secret_to_public
  |> OpenRouter.get "/ed25519/sign" ed25519_sign
  |> OpenRouter.get "/ed25519/verify" ed25519_verify
  |> OpenRouter.get "/ed25519/public" ed25519_public
  |> OpenRouter.get ~description:"Is service up or not" "/health" health
  |> OpenRouter.build
  |> Middlewares.cors_middleware
  |> Dream.logger
  |> Dream.run ~interface:"0.0.0.0" ~port:8080
