type pair*[F, S] = object
  first* : F
  second* : S

proc newPair*[F, S](first : F, second : S) : pair[F, S] =
  var result : pair[F, S]

  result.first = first
  result.second = second

  return result