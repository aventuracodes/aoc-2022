package aoc

import "core:os"
import "core:strings"
import "core:fmt"
import "core:math"

six :: proc() {
    data, _ := os.read_entire_file_from_filename("input.txt")
    defer delete(data)

    str := strings.clone_from_bytes(data)
    defer delete(str)

    // length := 4 // Part one
    length := 14 // Part two

    for i in length-1..<len(str) {
        unique := true
        for a in 0..<length {
            for b in a+1..<length {
                if str[i-a] == str[i-b] {
                    unique = false
                }
            }
        }
        if unique {
            fmt.println(i + 1)
            return
        }
    }
}