#!/bin/sh

directory=$1
yml_ending=$2

python_installed=""
ansible_installed=""
ansible_lint_installed=""
yamllint_installed=""

type python
if [ $? -eq 0 ]; then
    echo OK
    python_installed="installed"
else
    echo FAIL, Python is not installed!
fi


if [ $python_installed = "installed" ]; then
    if [ -z $yaml_ending]; then
        yml_ending=yml
    fi

    # require to pass path to ansible role
    if [ -z $directory ];then
        echo "No Ansible Role specified!"
        echo "You have to pass a path to an ansible role as argument!"
    else
        echo "You can pass as second argument your YAML file ending."
        echo "Default is: yml"
        # check directory of ansible role
        if [ -d $directory ]; then
            yamllint $directory/*.$yml_ending

            # check if defaults directory exists
            if [ -d $directory ]; then
            yamllint $directory/defaults/*.$yml_ending
            else
                echo "No defaults directory!"
            fi

            # check if handlers directory exists
            if [ -d $directory ]; then
                yamllint $directory/handlers/*.$yml_ending
            else
                echo "No handlers directory!"
            fi

            # check if meta directory exists
            if [ -d $directory ]; then
                yamllint $directory/meta/*.$yml_ending
            else
                echo "No meta directory!"
            fi

            # check if molecule directory exists
            if [ -d $directory ]; then
                yamllint $directory/molecule/*.$yml_ending
            else
                echo "No molecule directory!"
            fi

            # check if tasks directory exists
            if [ -d $directory ]; then
                yamllint $directory/tasks/*.$yml_ending
            else
                echo "No tasks directory!"
            fi

            # check if site.yml for ansible-lint exists
            if [ -d $directory ]; then
                ansible-lint $directory/site.$yml_ending -c $directory/.ansible-lint
            else
                echo "No site.yml specified!"
            fi

        else
            echo "Directory "$directory "does not exist!"
        fi
    fi
else
    echo "Python is not installed!"
fi




