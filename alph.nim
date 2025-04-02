import std/sequtils
import sys

proc readAlph*(src : seq[char]): seq[char] =
  return src

proc readAlph*(src : seq[string]) : seq[char] =
  return src.mapIt(it[0])