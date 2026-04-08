#!/usr/bin/env bash
install_brew_colima() {
    brew_formula_install colima

    brew services start colima
}
