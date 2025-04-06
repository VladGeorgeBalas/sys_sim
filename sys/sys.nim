import std/sequtils
import std/strutils

type state* = object
  marked* : bool
  start* : bool
  next* : seq[int]

proc echo*( src : state)=
  for i in src.next:
    stdout.write(i)
    stdout.write(" ")

  if src.start:
    write stdout, "start "

  if src.marked:
    write stdout, "marked "

  write stdout, '\n'

proc readSys*(alphabet : seq[char]) : seq[state] =
  var system : seq[state] = @[]
  var line : string = readLine(stdin)
  while not line.isEmptyOrWhitespace:
    var tmp_input : seq[string] = split(line, ' ')
    var tmp_state : state
    var tmp_state_atribute_length : int = 0

    if "start" in tmp_input:
      tmp_state.start = true
      tmp_state_atribute_length += 1
    else:
      tmp_state.start = false

    if "marked" in tmp_input:
      tmp_state.marked = true
      tmp_state_atribute_length += 1
    else:
      tmp_state.marked = false

    tmp_state.next = tmp_input[0..min((tmp_input.len - tmp_state_atribute_length - 1), alphabet.len)].mapIt(parseInt(it))
    if tmp_state.next.len < alphabet.len + 1:
      for i in 1..(tmp_state.next.len - alphabet.len + 1):
        tmp_state.next.add(-1)
    #echo tmp_state
    add(system, tmp_state)
    line = readLine(stdin)

  return system