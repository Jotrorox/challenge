package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
)

func main() {
	var code string
	if len(os.Args) > 1 {
		data, err := os.ReadFile(os.Args[1])
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error reading file: %v\n", err)
			os.Exit(1)
		}
		code = string(data)
	} else {
		data, err := io.ReadAll(os.Stdin)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error reading stdin: %v\n", err)
			os.Exit(1)
		}
		code = string(data)
	}

	tape := make([]byte, 30000)
	codePos := 0
	tapePos := 0

	for codePos < len(code) && tapePos >= 0 && tapePos < len(tape) {
		switch code[codePos] {
		case '[':
			if tape[tapePos] == 0 {
				depth := 1
				codePos++
				for depth > 0 && codePos < len(code) {
					if code[codePos] == '[' {
						depth++
					} else if code[codePos] == ']' {
						depth--
					}
					codePos++
				}
				codePos--
			} else {
				codePos++
			}
		case ']':
			if tape[tapePos] != 0 {
				depth := 1
				codePos--
				for depth > 0 && codePos >= 0 {
					if code[codePos] == ']' {
						depth++
					} else if code[codePos] == '[' {
						depth--
					}
					codePos--
				}
				codePos++
			} else {
				codePos++
			}
		case '+':
			tape[tapePos]++
			codePos++
		case '-':
			tape[tapePos]--
			codePos++
		case '>':
			tapePos++
			codePos++
		case '<':
			tapePos--
			codePos++
		case '.':
			fmt.Print(string(tape[tapePos]))
			codePos++
		case ',':
			tape[tapePos] = []byte{0}[0]
			reader := bufio.NewReader(os.Stdin)
			ch, _, _ := reader.ReadRune()
			tape[tapePos] = byte(ch)
			codePos++
		default:
			codePos++
		}
	}
}
