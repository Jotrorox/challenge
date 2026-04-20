import os

let code = if paramCount() > 0: readFile paramStr(1)
           else: readAll stdin

var
    tape = newSeq[char](30000)
    codePos = 0
    tapePos = 0

{.push overflowchecks: off.}
proc xinc(c: var char) = inc c
proc xdec(c: var char) = dec c
{.pop.}

proc run(): bool =
  while tapePos >= 0 and tapePos < tape.len and codePos < code.len:
    case code[codePos]
    of '[':
      if tape[tapePos] == '\0':
        var depth = 1
        inc codePos
        while depth > 0 and codePos < code.len:
          if code[codePos] == '[': inc depth
          elif code[codePos] == ']': dec depth
          inc codePos
        dec codePos
      else:
        inc codePos
    of ']':
      if tape[tapePos] != '\0':
        var depth = 1
        dec codePos
        while depth > 0 and codePos >= 0:
          if code[codePos] == ']': inc depth
          elif code[codePos] == '[': dec depth
          dec codePos
        inc codePos
      else:
        inc codePos
    of '+': xinc tape[tapePos]; inc codePos
    of '-': xdec tape[tapePos]; inc codePos
    of '>': inc tapePos; inc codePos
    of '<': dec tapePos; inc codePos
    of '.': stdout.write tape[tapePos]; inc codePos
    of ',': tape[tapePos] = stdin.readChar; inc codePos
    else: inc codePos

  return true

discard run()
