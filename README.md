# Tradinghorse

## abstract

This program is made for my report 「Polynomial dynamic activation function:活性化関数の学習」, and predicts up and down of the BTC prices.

## Usage
If you use this program, you have to install (the Julia language)[https://julialang.org/]!
1. you get source code by:
```
git clone https://github.com/QGMW22/pody_application
```
and you move to tradinghorse directory under the current directory.
```
#for Linux and Mac
cd ./tradinghorse
#for Windows
cd tradinghorse
```

2. Next, Reproduce the environment.
```
julia setup.jl
```

3. All you have to do is execute the command. If you want to use it with a traditional model, do as follows.
```
#for Linux and Mac
./tradinghorse.sh -traditional
#for Windows
./tradinghorse.bat -traditional
```
If you want to use it with a pody model, do as follows.
```
#for Linux and Mac
./tradinghorse.sh -pody
#for Windows
./tradinghorse.bat -pody
```