#!/bin/sh

set -e

BUILD_DIR="${1:-./build}"

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

for file in *; do
	case "${file##*.}" in
		"html" | "css")
			cp "${file}" "${BUILD_DIR}";;
		"js")
			terser --compress --mangle -o "/build/${file}" -- "${file}";;			
	esac
done
