open Tyxml;
let greet = who =>
  <html>
    <head> <title> "Home" </title> </head>
    <body> <h1> {Html.txt("Good morning, " ++ who ++ "!")} </h1> </body>
  </html>;
