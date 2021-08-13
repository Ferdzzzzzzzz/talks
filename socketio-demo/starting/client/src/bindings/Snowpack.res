@scope(("import", "meta")) @val external hot: bool = "hot"
@scope(("import", "meta", "hot")) @val
external accept: unit => unit = "accept"
