import std/strutils
import alph
import run
import sys
import ls

var system : seq[state]
var alphabet : seq[char]

#proc sort_seq( src : seq[any], sort_val : proc(any) : int) =

stdout.write('>')
var commLine = readLine(stdin)
while not commLine.isEmptyOrWhitespace():
  var comm : seq[string] = commLine.split(' ')
  if comm[0] == "alph":
    alphabet = readAlph(comm[1..comm.len-1])
  elif comm[0] == "lsAlph":
    lsAlph(alphabet)
  elif comm[0] == "sys":
    system = readSys(alphabet)
  elif comm[0] == "lsSys":
    lsSys(system)
  elif comm[0] == "run":
    let word : string = comm[1]
    run(system, alphabet, word)
  stdout.write('>')
  commLine = readLine(stdin)
