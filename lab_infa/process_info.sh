#!/bin/bash
ps aux
process_count=$(ps aux|wc -l)
echo "Количество процессов: $process_count"
