#!/bin/bash

# 入力数
if [[ $# -ne 2 ]]; then
    echo "Error: Expecting 2 args; found $# ($*)"
    exit 1
fi

# 入力が正の自然数
if ! [[ $1 =~ ^[0-9]+$ ]] || ! [[ $2 =~ ^[0-9]+$ ]]; then
    echo "Two args must be positive integer"
    echo "Usage: $0 <positive integer> <positive integer>"
    exit 1
fi

# メインの処理
gcd() {
    if [ "$2" -eq "0" ]
    then
        echo $1
    else
        gcd $2 `expr $1 % $2`
    fi
}

result=`gcd $1 $2`
echo $result
