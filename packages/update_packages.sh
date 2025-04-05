#!/bin/bash

# Clean list to only explicitly installed leaf packages (no version numbers)
pacman -Qet | awk '{print $1}' > packages.txt
