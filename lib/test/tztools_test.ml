let test_block_hash () =
  let expected = "BKiyb3usEE6nr1kwAP4UELUZmV4YzviKZxtq4m6kfNEHmdgEfFs" in
  let case =
    "0024b5ea0c7c05f5c1c6abab863bf9b863f715540babcbd399322ec3ef0ad0267f8e80176f0000000062930db004f7326e11c91f267c95c2babe578a10c0f3922e9be1eec03dc19badc3381e57c7000000210000000102000000040024b5ea0000000000000004ffffffff00000004000000005836158f2589e40b7b90734e8d9b5c564ebbd6c18a6a10adedc90c649828036c89e2159057457028f6d610ec4207dcbd6e81f7e6f4109a2e95458bad2266ea87000000006d9cfa3536f002000000529b6d1bdf2eec2d6361c4f4ac18ca374420eea39cef2acd2dc394d0d011105a7e39bf40a72d6df4b17e8395ad700db33441ba97297ea0c74b0a908ea0031700"
  in
  Alcotest.(check string)
    "block_hash_converter_of_string" expected
    (Lib.Block_hash.block_hash_of_string case)

let test_blake2b () =
  let expected =
    "b2e06daa2bdd6616cd1d66e739a112353e5192a134684706454d0db6382e0161" in
  let case = "1231" in
  Alcotest.(check string)
    "block_hash_converter_of_string" expected
    (Lib.Blake2B.blake2b_hash_of_string case)

let () =
  let open Alcotest in
  run "TzTool_tests"
    [
      ("Block_Hash", [test_case "converter_of_string" `Quick test_block_hash]);
      ("Blake2b", [test_case "converter_of_string" `Quick test_blake2b]);
    ]
