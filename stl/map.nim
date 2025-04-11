import ../util/pair
import std/typeinfo
import ../util/todo


type
  # K - key type, must be comparable >, <, ==
  # V - value type
  map_node*[K, V] = object
    #next nodes in AVL tree
    right : ptr map_node[K, V]
    left : ptr map_node[K, V]
    #balance factor for rebalancing tree
    balanceFactor* : int
    #content of the node, as pairs
    key* : K
    value : V
  # wrapper class for the AVL tree of map
  # should be only one visible to the user
  map*[K, V] =
    ptr map_node[K, V]

# map_node procs !hidden!

proc newMapNode*[K, T]() : ptr map_node[K, T] =
  return cast[ptr map_node[K,T]](alloc(sizeof(map_node[K, T])))

proc newMapNode*[K, T](src : pair[K, T]) : ptr map_node[K, T] =
  # dynamically non-GC'ed node allocation 
  result = cast[ptr map_node[K,T]](alloc(sizeof(map_node[K, T])))

  result.right = nil
  result.left = nil

  # will be set when inserted into the structure
  result.balanceFactor = 0
  
  result.key = src.first
  result.value = src.second

# necessary procs using pair<K, V> as base
# types of Key and Value
TODO("De facut la final, sunt doar nice-to-have")
#proc getKeyType(src : map) : Any
#proc getValueType(src : map) : Any

# basic constructors
proc newMap[K, T]() : map[K, T] = # no argument constructor
  return nil
TODO("Trebuie mai intai facute functiile de constructie arbore")
#proc newMap[K,T](src : map[K, T]) : map[K, T] # copy constructor
#proc newMapOf[K, T](src : varargs[pair[K, T]]) : map[K, T] # vararg constructor

# basic destructor
#proc deleteMap[K, T](src : map[K, T]) # general destructor

# iterator
#iterator Keys(src : map[K, T]) : K
#iterator Pairs(src : map[K, T]) : pair[K, T]

# check state
proc isEmpty*(src : map) : bool =
  return src == nil
proc isNotEmpty*(src : map) : bool =
  return src != nil
#proc size(src : map[K, T]) : uint

proc rightRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V]
proc leftRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V]
proc leftRightRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V]
proc rightLeftRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V]

# utility proc for setting balance factor
# should be private by default
proc balanceMap[K, V](src : var map[K, V]) : (ptr map_node[K, V], int) =
  var (right, right_len) : (ptr map_node[K, V], int) = (
    if src.right != nil:
      balanceMap[K, V](src.right)
    else: 
      (src.right, 0)
  )
  var (left, left_len) : (ptr map_node[K, V], int) = (
    if src.left != nil:
      balanceMap[K, V](src.left)
    else:
      (src.left, 0)
  )

  src.left = left
  src.right = right
  src.balanceFactor = right_len - left_len

  var rotated : bool = false
  if src.balanceFactor > 1:
    rotated = true
    if src.right.balanceFactor > 0:
      src = leftRotation(src)
    else:
      src = rightLeftRotation(src)
  elif src.balanceFactor < -1:
    rotated = true
    if src.left.balanceFactor < 0:
      src = rightRotation(src)
    else:
      src = leftRightRotation(src)

  if rotated == true:
    (right, right_len) = (
      if src.right != nil:
        balanceMap[K, V](src.right)
      else: 
        (src.right, 0)
    )
    (left, left_len) = (
      if src.left != nil:
        balanceMap[K, V](src.left)
      else:
        (src.left, 0)
    )

  return (src, (if right_len > left_len: right_len else: left_len) + 1)

# rotations for avl balancing
proc rightRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V] =
  let left : ptr map_node[K, V] = src.left
  let left_right : ptr map_node[K, V] = left.right

  left.right = src
  src.left = left_right
  
  return left

proc leftRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V] =
  let right : ptr map_node[K, V] = src.right
  let right_left : ptr map_node[K, V] = right.left

  right.left = src;
  src.right = right_left

  return right

proc leftRightRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V] =
  src.left = leftRotation(src.left)
  return rightRotation(src)

proc rightLeftRotation[K, V](src : var ptr map_node[K, V]) : ptr map_node[K, V] =
  src.right = rightRotation(src.right)
  return leftRotation(src)

# element manipulation
proc addElement*[K, T](dest : var map[K, T], src : pair[K, T]) =
  TODO("adauga verificare ca nu exista cumva deja cheia")

  if dest.isEmpty():
    dest = newMapNode(src)
  else:
    # gasim nodul unde trebuie adaugat
    var current_node : ptr map_node[K, T] = dest

    # cat timp nu e nod terminal ( frunza ) vedem unde trebuie sa il adaugam
    while current_node.right != nil or current_node.left != nil:
      if current_node.key > src.first and current_node.left != nil:
        current_node = current_node.left
      elif current_node.key > src.first and current_node.left == nil:
        break;
      elif current_node.key < src.first and current_node.right != nil:
        current_node = current_node.right
      elif current_node.key < src.first and current_node.right == nil:
        break;

    if current_node.key > src.first:
      current_node.left = newMapNode(src)
    else:
      current_node.right = newMapNode(src)

    var discardVal : int
    (dest, discardVal) =  balanceMap(dest)

# proc removeElement()

# element retrieval and modification
proc getElementByVal*[K, T](src : map[K, T], key : K) : T =
  var current : ptr map_node[K, T] = src
  
  while current.key != key and current != nil:
    if current.key > key:
      current = current.left
    elif current.key < key:
      current = current.right

  return current.value

# proc getElementByPtr[K, T]() : ptr T
# proc getElementByRef[K, T]() : ref T

# operators
# acces operators '[]'
# operator `[]=`
# assignment operators '='
# comparison operators '=='
# reunion/addition operators '+' '+='
# difference/substraction operators '-' '-='
# junction/and operators '&&'
# disjunction/or operators '||'

# necessary procs using tuple as base