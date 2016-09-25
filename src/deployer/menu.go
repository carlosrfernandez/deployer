package main

import (
    "os"
)

func Menu() {
    version := os.Getenv("DEPLOYER_VERSION")
    multilinePrint(
        "NAME:",
        "   " + os.Args[0] + " - Manage cloud environment",
        "",
        "USAGE:",
        "    " + os.Args[0] + " [global options] command [command options] [arguments...]",
        "",
        "VERSION:",
        "    " + version + "",
        "",
        "COMMANDS:",
        "      help, h  Shows a list of commands or help for one command",
        "      describe  give details on an environment and its current status",
        "",
        "GLOBAL OPTIONS:",
        "    --help, -h     show help",
        "    --version, -v  print the version")
}
