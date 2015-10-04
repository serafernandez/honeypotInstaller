#!/bin/bash

# set -x
set -e
function crearCarpeta {
    borrarCarpeta $1
    cd ~
    mkdir $1
    cd $1
}

function borrarCarpeta {
    cd ~
    if [ -e $1 ] ; then
        sudo rm -rf $1
    fi
}

function glastopf {
    echo "----------------------------------------------------------------------------"
    echo "Instalo glastopf"
    echo "----------------------------------------------------------------------------"
    crearCarpeta glastopf
    wget "$1/api/script/?text=true&script_id=9" -O deploy.sh && sudo bash deploy.sh $1 $2
}

function kippo {
    echo "----------------------------------------------------------------------------"
    echo "Instalo kippo"
    echo "----------------------------------------------------------------------------"
    crearCarpeta kippo
    wget "$1/api/script/?text=true&script_id=5" -O deploy.sh && sudo bash deploy.sh $1 $2
}

function conpot {
    echo "----------------------------------------------------------------------------"
    echo "Instalo conpot"
    echo "----------------------------------------------------------------------------"
    crearCarpeta conpot
    wget "$1/api/script/?text=true&script_id=4" -O deploy.sh && sudo bash deploy.sh $1 $2
}

function finish {
    borrarCarpeta glastopf
    borrarCarpeta kippo
    borrarCarpeta conpot
    echo "----------------------------------------------------------------------------"
    echo "Termino de instalar"
    echo "----------------------------------------------------------------------------"
    exit 0
}

if [ $# -le 2 ] ; then
    echo "El uso correcto es: $0 <mhn_server_url> <deploy_key> <toInstall>"
    echo "Ejemplo $0 http://192.168.0.100 pKEHIQ1a all"
    exit 1
else
    if [ $3 == "all" ] ; then
        echo "----------------------------------------------------------------------------"
        echo "Instalo todos"
        echo "----------------------------------------------------------------------------"
        glastopf $1 $2
        kippo $1 $2
        conpot $1 $2
        finish
    else
        for arg in $@ ; do
            if [ $arg == "glastopf" ] ; then
                glastopf $1 $2
            fi
            if [ $arg == "kippo" ] ; then
                kippo $1 $2
            fi
            if [ $arg == "conpot" ] ; then
                conpot $1 $2
            fi
        done
    fi
fi
