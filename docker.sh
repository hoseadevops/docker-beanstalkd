#!/bin/bash

set -e

project_path=$(cd $(dirname $0); pwd -P)
project_docker_path="$project_path/docker"
source $project_docker_path/bash.sh
developer_name=$('whoami');


#----------------------
app_basic_name=$(read_kv_config .env APP_NAME);
beanstalkd_port=$(read_kv_config .env BEANSTALKD_PORT);

app="$developer_name-$app_basic_name"


# image
beanstalkd_image=hoseadevops/own-beanstalkd:1.10

# container
beanstalkd_container=$app-beanstalkd1.10

# container dir
project_docker_beanstalkd_dir="$project_docker_path/beanstalkd"
project_docker_runtime_dir="$project_docker_path/runtime"           # app runtime
project_docker_persistent_dir="$project_docker_path/persistent"     # app persistent

app_config="$project_docker_persistent_dir/config"

#---------- beanstalkd container ------------#
source $project_docker_path/beanstalkd/container.sh


function run()
{
    run_beanstalkd
}

function restart()
{
    restart_beanstalkd
}

function rebuild()
{
    clean_persistent
    restart_beanstalkd
}

function clean()
{
    rm_beanstalkd
}
function clean_all()
{
    rm_beanstalkd
    clean_persistent
}

function clean_persistent()
{
    run_cmd "rm -rf $project_docker_persistent_dir/*"
}

function help()
{
cat <<EOF
    Usage: sh docker.sh [options]

        Valid options are:

        run
        restart
        rebuild
        clean
        clean_all

        push_image

        help  show this message
EOF
}

action=${1:-help}
ALL_COMMANDS="run restart rebuild clean clean_all push_image";
list_contains ALL_COMMANDS "$action" || action=help
$action "$@"

