#!/bin/bash

run=/opt/vyatta/bin/vyatta-op-cmd-wrapper
$run show version
$run show interfaces
$run show system login users
