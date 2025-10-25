#!/bin/bash
echo "Введите число: "
read n
if (( $n % 2 == 0 )) then
echo "Число $n чётное"
else
echo "Число $n нечётно"
fi
