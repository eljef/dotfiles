#!/bin/bash
# Copyright (c) 2020-2024, Jef Oliver
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
# IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# SPDX-License-Identifier: 0BSD
#
# Authors:
# Jef Oliver <jef@eljef.me>


# BOLD: Bold with default color
BOLD="\033[1m"

# RESET: Color reset (Reset to default)
RESET="\033[0m"
# START: Start color (Bold, Green)
START="\033[1;32m"

# ERROR_START: Error Color (Bold, Red)
ERROR_START="\033[1;31m"
# INFO_START: Info Color (Bold, Cyan)
INFO_START="\033[1;36m"
# WARN_START: Warning Color (Bold, Yellow or Brown on some systems)
WARN_START="\033[1;33m"


# base_dir: find directory holding specified path
#           works backward one directory at a time until found
#           fails with an error message if needed
#
#    Args:
#         $1: start directory
#         $2: path to look for.
#
#    example:
#            base_dir "$(pwd)" "some_dir"
function base_dir() {
    local _basedir
    cd_or_error "${1}"

    _basedir="$(pwd -P)"
    while [ "${_basedir}" != "" ]
    do
        if [[ -d "${_basedir}/${2}" ]]; then
            break
        fi
        _basedir="$(dirname "${_basedir}")"
    done

    if [[ "${_basedir}" == "" ]]; then
        failure "could not find ${2}"
    fi

    echo "${_basedir}"
}


# cd_or_error: change directory
#              failing with an error message if needed
#
#    Args:
#         $1: path to change directory to
#
#    example:
#            cd_or_error path/to/change/to
function cd_or_error() {
    cd "${1}" || failure "failed to change directory to ${1}"
}


# check_dir: checks if a dir exists
#            failing with an error message if needed
#
#    Args:
#         $1: path to directory to check
#
#    example:
#            check_dir path/to/some/dir
function check_dir() {
    if [[ ! -d "${1}" ]]; then
        failure "not a directory or does not exist: ${1}"
    fi
}


# check_env: checks if an environment variable is set and
#            contains data
#
#    Args:
#         $1: name of variable to check
#
#    example:
#            check_env SOME_VAR_NAME
function check_env() {
    local _VAR_CHECK
    _VAR_CHECK="${!1}"
    if [ -z "${_VAR_CHECK}" ]; then
        failure "environment variable not set: ${1}"
    fi
}


# check_file: checks if a file exists
#            failing with an error message if needed
#
#    Args:
#         $1: path to file to check
#
#    example:
#            check_file path/to/some/file.ext
function check_file() {
    if [[ ! -f "${1}" ]]; then
        failure "not a file or does not exist: ${1}"
    fi
}


# check_help: Checks if a provided variable is a help request
#             Runs print_help if requested.
#
#    Args:
#         $1: Variable to check
#
#    example:
#            check_help "${some_var}"
function check_help() {
    if [[ "${1}" == "-h" || "${1}" == "--help" || "${1}" == "help" ]]; then
        print_help
        exit 0
    fi
}


# check_help_and_empty: Checks if a provided variable is empty,
#                       or if it is a help request.
#                       Runs print_help if requested.
#
#    Args:
#         $1: Variable to check
#
#    example:
#            check_help_and_empty "${some_var}"
function check_help_and_empty() {
    if [[ -z "${1}" ]]; then
        print_help
        exit 1
    fi
    if [[ "${1}" == "-h" || "${1}" == "--help" || "${1}" == "help" ]]; then
        print_help
        exit 0
    fi
}


# check_installed: Checks if required executables are installed.
#
#    Args:
#         $@: Space separated list of executables to check for.
#
#    example:
#            check_installed "executable_one" "executable_two"
function check_installed() {
    local _exec_name
    for _exec_name in "$@"
    do
        if ! type -P "${_exec_name}" > /dev/null; then
            print_info "the following executables are required for this script to run:"
            print_info "$*"
            failure "missing executable: ${_exec_name}"
        fi
    done
}


# check_installed_silent: Checks if required executable is installed, exiting
#                         with an un-styled message and zero status if not
#                         installed. This function is useful in scripts that
#                         will be run by another program, such as tmux, where a
#                         non-zero exit is not desired.
#
#    Args:
#         $1: required executable
#         $2: message to print if not found
#
#    example:
#            check_installed_silent "git" "git not found"
function check_installed_silent() {
    if ! type -P "${1}" > /dev/null; then
        echo "${2}"
        exit 0
    fi
}


# check_root: checks if the user has root privileges
#
#    example:
#            check_root
function check_root() {
    if [[ ${EUID} -ne 0 ]]; then
        failure "This script must be run with root privileges."
    fi
}


# del_file: deletes the file if it exists
#
#    Args:
#         $1: path to delete
#         $2: if exists, the command will operate silently
#
#    example:
#            del_file "path/to/file.txt"
function del_file() {
    if [ -z "${2}" ]; then
        print_info "rm \"${1}\""
    fi
    if [[ -f "${1}" ]]; then
        rm "${1}" || failure "could not remove ${1}"
    fi
}


# download_install_file: Downloads and installs a file
#
#    Args:
#         $1: mode (ie 0644 or 0755)
#         $2: URI of file to download
#         $3: destination to install file to
#
#    example:
#            download_install_file 0644 https://somewebsite.com/file.txt path/to/file.txt
function download_install_file() {
    print_install_file "${1}" "${2}" "${3}"
    curl -L -o "${3}" "${2}" >/dev/null 2>&1 || failure "could not download ${2}"
    chmod "${1}" "${3}" || failure "could not set mode ${1} on ${3}"
}


# error_help: prints the help message then exits the script
#             with a non-zero exit code
#
#    example:
#            error_help
function error_help() {
    print_help
    exit 1
}


# error_no_exist: fails with a does not exist message
#
#    Args:
#         $1: path that does not exist
#
#    example:
#            error_no_exist "path/that/does/not/exist"
function error_no_exist() {
    failure "${1} does not exist"
}


# failure: echo a command and exit with an error code
#
#    example:
#            failure "some error message"
function failure() {
    print_error "${1}"
    exit 1
}


# install_file: install a file on the system
#               failing with an error message if needed
#
#    Args:
#         $1: mode (ie 0644 or 0755)
#         $2: origin file to install
#         $3: destination to install file to
#
#    example:
#            install_file 0644 path/to/original/file path/to/file/at
function install_file() {
    print_install_file "${1}" "${2}" "${3}"
    install -m "${1}" "${2}" "${3}" || failure "failed to install ${2} -> ${3} :: ${1}"
}


# make_directory: create a new directory
#                 failing with an error message if needed
#
#    Args:
#         $1: Path to directory to create
#
#    example:
#            make_directory "path/to/create"
function make_directory() {
    if [[ ! -d "${1}" ]]; then
        print_info "mkdir -p \"${1}\""
        mkdir -p "${1}" || failure "failed to create directory ${1}"
    fi
}


# print_info: prints an info message
#
#    Args:
#         $1: Message to print
#
#    example:
#            print_info "Some Message"
function print_info() {
    echo -e "$(_sprint_leader INFO) $(_sprint_wrap "${INFO_START}" "${1}")"
}


# print_info_2: prints an indented info message
#               this should be used after print_info to provide additional
#               context.
#
#    Args:
#         $1: Message to print
#
#    example:
#            print_info_2 "Some Message"
function print_info_2() {
    echo -e "$(_sprint_leader INFO) $(_sprint_wrap "${START}" "--") $(_sprint_wrap "${BOLD}" "${1}")"
}


# print_install_file: prints an install message
#
#    Args:
#         $1: mode (ie 0644 or 0755)
#         $2: origin file
#         $3: destination file
#
#    example:
#            print_install_file 0644 some_file destination/of/file
function print_install_file() {
    echo -e "$(_sprint_leader INFO) $(_sprint_wrap "${INFO_START}" "Install: ${2}")\n" \
            "\t\t\t$(_sprint_wrap "${START}" "->") $(_sprint_wrap "${INFO_START}" "${1}::${3}")"
}


# print_error: prints an error message
#
#    Args:
#         $1: Message to print
#
#    example:
#            print_error "Some Message"
function print_error() {
    echo -e "\n$(_sprint_leader ERROR) $(_sprint_wrap "${ERROR_START}" "${1}")\n" 2>&1
}


# print_help: prints a help statement
#
#    example:
#            print_help
#
#    note:
#         Before this function is called, ${HELPSTATEMENT}
#         must be defined in the script using this function.
function print_help() {
    echo -e "${HELPSTATEMENT}"
}

# print_move: prints a move statement
#
#    Args:
#         $1: Source path
#         $2: Destination path
#
#    example:
#            print_move "some/path" "new/path"
function print_move() {
    echo -e "$(_sprint_leader INFO) $(_sprint_wrap "${INFO_START}" "${1}") $(_sprint_wrap "${START}" "->") "\
            "$(_sprint_wrap "${INFO_START}" "${2}")"
}


# print_warn: prints a warning message
#
#    Args:
#         $1: Message to print
#
#    example:
#            print_warn "Some Message"
function print_warn() {
    echo -e "$(_sprint_leader WARN) $(_sprint_wrap "${WARN_START}" "${1}")"
}


# _sprint_leader: Returns a leader to use, starting with the wanted color.
#
#    Args:
#         $1: Message Level to use
#             (INFO, WARN, ERROR)
#
#    example:
#            $some_var=$(_sprint_leader INFO)
function _sprint_leader() {
    case "${1}" in
        WARN)
            echo " $(_sprint_wrap "${START}" "-|")"\
                 "$(_sprint_wrap "${WARN_START}" "**")"\
                 "$(_sprint_wrap "${START}" "|-") "\
                 "$(_sprint_wrap "${WARN_START}" "WARNING:") "
            ;;
        ERROR)
            echo " $(_sprint_wrap "${START}" "-|")"\
                 "$(_sprint_wrap "${ERROR_START}" "**")"\
                 "$(_sprint_wrap "${START}" "|-")"\
                 "$(_sprint_wrap "${ERROR_START}" "ERROR:") "
            ;;
        *)
            echo " $(_sprint_wrap "${START}" "-|")"\
                 "$(_sprint_wrap "${INFO_START}" "**")"\
                 "$(_sprint_wrap "${START}" "|-") "
            ;;
    esac
}


# _sprint_wrap: Returns a string to use, wrapped with a color and reset.
#
#    Args:
#         $1: Color to use
#         $2: String to wrap
#
#    example:
#            $some_var$(_sprint_wrap $START_INFO "text to wrap")
function _sprint_wrap() {
    echo "${1}${2}${RESET}"
}
