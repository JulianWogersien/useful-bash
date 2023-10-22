#!/bin/sh

find ./ -not \( -path ./.git -prune \) -not \( -name "README*" -prune \) -not \( -name "LICENSE*" -prune \) -type f -exec wc -l {} \; | awk '{total += $1} END{print total}'