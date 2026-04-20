import os

fn main() {
	mut code := ''
	if os.args.len > 1 {
		code = os.read_file(os.args[1]) or { '' }
	} else {
		f := os.open('/dev/stdin')!
		mut data := []u8{len: 65536}
		n := f.read(mut data)!
		code = data[0..n].bytestr()
	}

	mut tape := []u8{len: 30000}
	mut code_pos := 0
	mut tape_pos := 0

	for code_pos < code.len && tape_pos >= 0 && tape_pos < tape.len {
		match code[code_pos] {
			`[` {
				if tape[tape_pos] == 0 {
					mut depth := 1
					code_pos++
					for depth > 0 && code_pos < code.len {
						if code[code_pos] == `[` {
							depth++
						} else if code[code_pos] == `]` {
							depth--
						}
						code_pos++
					}
					code_pos--
				} else {
					code_pos++
				}
			}
			`]` {
				if tape[tape_pos] != 0 {
					mut depth := 1
					code_pos--
					for depth > 0 && code_pos >= 0 {
						if code[code_pos] == `]` {
							depth++
						} else if code[code_pos] == `[` {
							depth--
						}
						code_pos--
					}
					code_pos++
				} else {
					code_pos++
				}
			}
			`+` {
				tape[tape_pos]++
				code_pos++
			}
			`-` {
				tape[tape_pos]--
				code_pos++
			}
			`>` {
				tape_pos++
				code_pos++
			}
			`<` {
				tape_pos--
				code_pos++
			}
			`.` {
				print(rune(tape[tape_pos]))
				code_pos++
			}
			`,` {
				f := os.open('/dev/stdin')!
				mut buf := []u8{len: 1}
				f.read(mut buf)!
				tape[tape_pos] = buf[0]
				code_pos++
			}
			else {
				code_pos++
			}
		}
	}
}
