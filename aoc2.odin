package aoc;

import "core:os"
import "core:strings"
import "core:fmt"

two :: proc() {
    data, _ := os.read_entire_file_from_filename("input.txt")
    defer delete(data)

    str := strings.clone_from_bytes(data)
    defer delete(str)

    lines := strings.split_lines(str)
    defer delete(lines)

    score := 0
    for line in lines {
        reader : strings.Reader
        strings.reader_init(&reader, line)

        l, _, _ := strings.reader_read_rune(&reader)
        strings.reader_read_rune(&reader)
        r, _, _ := strings.reader_read_rune(&reader)
        
        // Part one
        // r -= 23;
        // if l == r {
        //     score += 3
        // } else if
        //  (l == 'A' && r == 'B') ||
        //  (l == 'B' && r == 'C') ||
        //  (l == 'C' && r == 'A') {
        //     score += 6
        // }
        // score += int(r - 'A' + 1)

        // Part two
        need : rune
        if r == 'Y' {
            score += 3;
            need = l
        } else if r == 'Z' {
            score += 6;
            if l == 'A' {
                need = 'B'
            } else if l == 'B' {
                need = 'C'
            } else {
                need = 'A'
            }
        } else {
            if l == 'A' {
                need = 'C'
            } else if l == 'B' {
                need = 'A'
            } else {
                need = 'B'
            }
        }
        score += int(need - 'A' + 1)
    }

    fmt.println(score)
}