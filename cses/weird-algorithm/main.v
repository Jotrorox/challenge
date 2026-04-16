import os

fn main() {
	input := os.input("> ")
	mut num := input.int() 

	if num == 0 {
		println("Please enter a number")
	}

	print(num)
	for num != 1 {
		if num % 2 == 0 {
			num = num / 2
		} else {
			num = (num * 3) + 1
		}
		print(" " + num.str())
	}
	println("")
}