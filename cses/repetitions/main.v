import os

fn main() {
	input := os.input("> ").split("")

	mut max := 0
	mut cur := 1

	for i, ch in input {
		if i == 0 {
			continue
		}

		if ch == input[i-1] {
			cur++
		} else {
			cur = 1
		}

		if cur > max {
			max = cur
		}
	}

	println(max)
}