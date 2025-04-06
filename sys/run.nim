import sys
import alph
import std/strutils

proc run*(system : seq[state], alphabet : seq[char], word : string) =
  if not word.isEmptyOrWhitespace:
    let path:seq[char] = @word
    var cur : state
    for i in system:
      if i.start:
        cur = i
        break

    for i in path:
      let index:int = find(alphabet, i)
      for j in system:
        if j.next[0] == cur.next[index + 1]:
          cur = j
          break
      stdout.write(cur.next[0])
      stdout.write(" ")
    echo "\nresult:", cur.next[0], (if cur.marked: " marked" else: "")