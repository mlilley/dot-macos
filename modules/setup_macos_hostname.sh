#!/usr/bin/env bash
setup_macos_hostname() {
    scutil --set HostName zoidberg
    scutil --set LocalHostName zoidberg
    scutil --set ComputerName zoidberg
}