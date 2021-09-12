#!/bin/sh

traditional()
{
    julia main.jl
}

pody()
{
    julia main2.jl
}

if [ $1 = "-traditional" ]; then
    traditional
elif [ $1 = "-pody" ]; then
    pody
else
    echo "\e[30;47;1mplease use optioin `-traditional` or `-pody`.\e[0m"
fi