package aoc

import "core:os"
import "core:strings"
import "core:fmt"

three :: proc() {
    data, _ := os.read_entire_file_from_filename("input.txt")
    defer delete(data)

    str := strings.clone_from_bytes(data)
    defer delete(str)

    lines := strings.split_lines(str)
    defer delete(lines)

    score := 0

    // Part one
    // for line in lines {
    //     hlen := len(line) / 2
    //     fhalf := line[:hlen]
    //     shalf := line[hlen:]

    //     for l in 'a'..='z' {
    //         fc := strings.contains_rune(fhalf, l)
    //         sc := strings.contains_rune(shalf, l)

    //         if (fc >= 0 && sc >= 0) {
    //             score += int(l - 'a' + 1)
    //         }
    //     }

    //     for u in 'A'..='Z' {
    //         fc := strings.contains_rune(fhalf, u)
    //         sc := strings.contains_rune(shalf, u)

    //         if (fc >= 0 && sc >= 0) {
    //             score += int(u - 'A' + 27)
    //         }
    //     }
    // }
    
    // Part two
    for i := 0; i < len(lines); i += 3 {
        for c in lines[i] {
            c1 := strings.contains_rune(lines[i+1], c)
            c2 := strings.contains_rune(lines[i+2], c)

            if c1 >= 0 && c2 >= 0 {
                if c >= 'a' {
                    score += int(c - 'a' + 1)
                } else {
                    score += int(c - 'A' + 27)
                }
                break
            }
        }
    }

    fmt.println(score)
}