#!/usr/bin/env bash

profile=$(powerprofilesctl get)

case "$profile" in
	"performance")
		clean_profile="Perf"
		;;
	"balanced")
		clean_profile="Bal"
		;;
	"power-saver")
		clean_profile="Save"
		;;
esac

echo "$clean_profile"
