#!/bin/bash

update() {

        if ! sudo apt update; then
                echo "Update Failed"
                exit 1
        fi

        echo "Update Completed"

        if ! sudo apt upgrade -y; then
                echo "Upgrade Failed"
                exit 1
        fi

        echo "Upgrade Completed"
}

install_python() {

        python_path="/usr/bin/python3"
        pip_path="/usr/bin/pip"

        if [[ -x $python_path ]]; then
                echo "Python is installed"
                python3 --version
        else
                echo "Installing Python3..."
                if ! sudo apt install python3 -y; then
                        echo "Python Installation Failed"
                        exit 1
                fi

                echo "Pyton3 has been installed"
                python3 --version
        fi

        if [[ -x $pip_path ]]; then
                echo "Python Pip is installed"
                pip3 --version
        else
                echo "Installing pip3..."
                if ! sudo apt install python3-pip -y; then
                        echo "Python Pip Installation Failed"
                        exit 1
                fi

                echo "Pip3 has been installed"
                pip3 --version
        fi

}

install_update
install_python
