#!/bin/bash

# 入力数が2つであること
if [[ $# -ne 2 ]]; then
    echo "Error: Expecting 2 args; found $# ($*)"
    exit 1
fi

# 入力が正の整数であること
if ! [[ $1 =~ ^([1-9][0-9]*|0)$ && $2 =~ ^([1-9][0-9]*|0)$ ]]; then
    echo "Error: 2 args must be positive integer; found ($*)"
    exit 1
fi

# 入力の片方が0ではないこと
if [[ $1 == 0 ]] && [[ $2 == 0 ]]; then
    echo "Error: Either arg must be grater than 0; found ($*)"
    exit 1
fi

# 整数の最大値より小さいこと
maxIntError() {
    echo "Error: 2 args must be smaller than 9223372036854775808"
    exit 1
}
trap maxIntError ERR
{ test 0 -eq $1 > /dev/null 2>&1 || expr $1 + 0 > /dev/null 2>$1; }
{ test 0 -eq $2 > /dev/null 2>&2 || expr $2 + 0 > /dev/null 2>$2; }


# メインの処理
gcd() {
    if [[ $2 == 0 ]]
    then
        echo $1
    else
        gcd $2 `expr $1 % $2`
    fi
}

result=`gcd $1 $2`
echo $result
