#!/bin/bash
status=$(systemctl is-active fail2ban 2>/dev/null)
case "$status" in
    active) echo 1 ;;
    inactive|failed) echo 0 ;;
    *) echo -1 ;;
esac

