```main :: proc() {
    stream := os.stream_from_handle(os.stdin)

    // Read a byte:
    byte, _ := io.read_byte(stream)

    // Read a rune/character:
    ch, _, _ := io.read_rune(stream)

    // Read a specific amount of bytes:
    buf: [100]u8
    io.read_full(stream, buf[:])

    // `bufio`

    s: bufio.Scanner
    bufio.scanner_init(&s, stream)
    defer bufio.scanner_destroy(&s)

    // By default, it splits per line:
    _ := bufio.scanner_scan(&s)
    line := bufio.scanner_text(&s)

    // Can also do per word:
    s.split = bufio.scan_words
    _ := bufio.scanner_scan(&s)
    word := bufio.scanner_text(&s)

    // Or per rune/character:
    s.split = bufio.scan_runes
    _ := bufio.scanner_scan(&s)
    ch2 := bufio.scanner_text(&s)
}
```
