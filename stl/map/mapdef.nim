import ../../pair

proc newMapNode*[K, T]() : ptr mapNode[K, T] =
  return cast[mapNode[K,T]](alloc(sizeof(mapNode[K, T])))

proc newMapNode*[K, T](src : pair[K, T]) : ptr mapNode[K, T] =
  result = cast[mapNode[K,T]](alloc(sizeof(mapNode[K, T])))
  result.right = nil
  result.left = nil
  result.balanceFactor = nil
  result.key = src.first
  result.value = src.second