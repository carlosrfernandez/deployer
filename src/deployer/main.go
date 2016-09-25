package main

import (
    "os"
    "fmt"
)

func main() {
    if len(os.Args) == 1 {
        Menu()
        return
    }

    exitCode := 0
    switch os.Args[1] {
        case "describe":
            exitCode = Describe(false)
        case "serve":
            exitCode = serve()
        default:
            fmt.Printf("%q is not valid command.\n", os.Args[1])
            exitCode = 2
    }

    os.Exit(exitCode)
}
