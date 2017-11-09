#!/bin/bash
set -e


function run_beanstalkd()
{

    local beanstalkd_binlog_dir="$project_docker_persistent_dir/beanstalkd/binlog"

    recursive_mkdir "$beanstalkd_binlog_dir"

    local args='--restart=always'

    args="$args --cap-add SYS_PTRACE"

    args="$args -p $beanstalkd_port:11300"

    args="$args -v $beanstalkd_binlog_dir:/var/lib/beanstalkd/binlog"

    args="$args -v $project_path:$project_path"
    args="$args -w $project_path"

    local cmd='bash docker.sh _run_cmd_php_container'

    run_cmd "docker run -d $args -h $beanstalkd_container --name $beanstalkd_container $beanstalkd_image /usr/bin/beanstalkd -b /var/lib/beanstalkd/binlog -F"
}

function rm_beanstalkd()
{
    rm_container $beanstalkd_container
}

function restart_beanstalkd()
{
    rm_beanstalkd
    run_beanstalkd
}