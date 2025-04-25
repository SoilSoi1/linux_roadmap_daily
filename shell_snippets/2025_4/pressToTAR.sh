#!/bin/bash
TARGET_DIR=$1
tar -czvf backup_$(basename "$TARGET_DIR")_$(date +%Y%m%d).tar.gz "$TARGET_DIR"
