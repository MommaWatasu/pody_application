@echo off
cd /d %~dp0

if "%~1" == "-traditional" (
    call :traditional
) else if "%~1" == "-pody" (
    call :pody
) else (
    echo "please use option `-traditional` or `-pody`"
)

:traditional
julia main.jl
cmd /k

:pody
julia main2.jl
cmd /k