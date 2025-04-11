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
    key : K
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

# utility proc for setting balance factor
# should be private by default
proc setBalanceFactor(src : var map) : int =
  let right_len : int = if src.right != nil: setBalanceFactor(src.right) else: 0
  let left_len : int = if src.left != nil: setBalanceFactor(src.left) else: 0

  src.balanceFactor = right_len - left_len

  return (if right_len > left_len: right_len else: left_len) + 1

# rotations for avl balancing
proc rightRotation(src : var ptr map_node) : ptr map_node =
  TODO("tradu in engleza")
  # valorile ce vor fi mutate
  # subarborele din stanga
  let left : ptr map_node = src.left

  # subarborele din dreapta al celui din stanga
  # daca este nil nu conteaza deoarece oricum se muta
  let left_right : ptr map_node = left.right

  # rotatie la dreapta
  left.right = src

  # mutam restul in golul ramas
  src.left = tmp_right
  
  return left

proc leftRotation(src : var ptr map_node) : ptr map_node =
  let right : ptr map_node = src.right
  let right_left : ptr map_node = right.left

  right.left = src;
  src.right = right_left

  return right

proc leftRightRotation(src : var ptr map_node) : ptr map_node =
  src.left = leftRotation(src.left)
  return rightRotation(src)

proc rightLeftRotation(src : var ptr map_node) : ptr map_node =
  src.right = rightRotation(src.right)
  return leftRotation(src)

# utility proc to balance tree
# should be private by default
proc balanceMapAVL(src : var map_node) = 
  if(src.left != nil and src.left.b)balanceMapAVL

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

    discard setBalanceFactor(dest)

# proc remove()

# element retrieval and modification
# proc getElement[K, T](key : K) : T
# proc getElementByPtr[K, T]() : ptr T
# proc getElementByRef[K, T]() : ref T

# operators
# acces operators '[]'
# assignment operators '='
# comparison operators '=='
# reunion/addition operators '+' '+='
# difference/substraction operators '-' '-='
# junction/and operators '&&'
# disjunction/or operators '||'

# necessary procs using tuple as base