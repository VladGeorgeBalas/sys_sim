import sys

proc lsSys*(system : seq[state])=
  echo system.len
  for i in system:
          echo i

proc lsAlph*(alph : seq[char]) =
  for i in alph:
    stdout.write(i)
    stdout.write(" ")
  stdout.write('\n')