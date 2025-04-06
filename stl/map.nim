import ../pair
import std/typeinfo
import ../util/todo
import map/mapdef

type
  # K - key type, must be comparable >, <, ==
  # V - value type
  mapNode[K, V] = object
    #next nodes in AVL tree
    right : ptr mapNode[K, V]
    left : ptr mapNode[K, V]
    #balance factor for rebalancing tree
    balanceFactor : int
    #content of the node, as pairs
    key : K
    value : V
  # wrapper class for the AVL tree of map
  # should be only one visible to the user
  map*[K, V] =
    ptr mapNode[K, V]

# map_node procs !hidden!
proc newMapNode[K, T]() : ptr mapNode[K, T] # not recommended
proc newMapNode[K, T](src : pair[K, T]) : ptr mapNode[K, T] # recommended

# necessary procs using pair<K, V> as base
# types of Key and Value
#proc getKeyType(src : map) : Any
#proc getValueType(src : map) : Any

# basic constructors
#proc newMap[K, T]() : map[K, T] # no argument constructor
TODO("Trebuie mai intai facute functiile de constructie arbore")
#proc newMap[K,T](src : map[K, T]) : map[K, T] # copy constructor
#proc newMapOf[K, T](src : varargs[pair[K, T]]) : map[K, T] # vararg constructor

# basic destructor
#proc deleteMap[K, T](src : map[K, T]) # general destructor

# iterator
#iterator Keys(src : map[K, T]) : K
#iterator Pairs(src : map[K, T]) : pair[K, T]

# check state
#proc isEmpty(src : map[K, T]) : bool
#proc isNotEmpty(src : map[K, T]) : bool
#proc size(src : map[K, T]) : uint

# element manipulation

# operators
# acces operators '[]'
# assignment operators '='
# comparison operators '=='
# reunion/addition operators '+' '+='
# difference/substraction operators '-' '-='
# junction/and operators '&&'
# disjunction/or operators '||'

# necessary procs using tuple as base