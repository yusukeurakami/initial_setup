#!/usr/bin/env bash
# -*- Yusuke Urakami -*-

function _formatter {
    echo "formatting $1"
    line=$1

    if [ "${line##*.}" = "py" ]; then
	    # import sorter options to make it compatible with black
	    isort --line-length=120 --multi-line=3 --trailing-comma --force-grid-wrap=0 --use-parentheses -n $1

	    # PEP8 compliant formatter
	    black --skip-string-normalization --line-length 120 --config "${HOME}/.local/pyproject_for_local_format.toml" $1

	    # Code style checker to checking if code is compliant with PEP8, and also check the programming error
	    flake8 --max-line-length=120 --ignore=E203,E266,E402,E501,W503,E731 $1

      # Type checking with mypy
      mypy --ignore-missing-imports $1

    elif [ "${line##*.}" = "hpp" ] || [ "${line##*.}" = "cpp" ] || [ "${line##*.}" = "c" ] || [ "${line##*.}" = "h" ]; then
        clang-format -i -style=file $1
        # cppcheck $1
        cpplint --linelength=120 --filter=-whitespace/indent,-whitespace/parens,-legal/copyright,-build/include_order,-runtime/references,-build/c++11,-build/namespaces,-build/header_guard,-readability/todo,-runtime/string $1
    else
	    pre-commit run --files $line;
    fi
}

function formatter {
  maxdepth="-maxdepth"; depth=1

  # check recursive flag
  local recursive=0;
  while getopts "r:" opt; do
    case $opt in
      r) recursive=1; echo $1; shift; echo $1;
    esac
  done
  if [ $recursive -eq 1 ]; then
       maxdepth=""; depth="";
  fi

  # when path not exists
  if [ ! -e $1 ]; then
	echo "target file or directory doesn't exists!"; return 0;
  fi
  # when path is file
  if [ -f $1 ]; then
	for file in "$@"; do
		if [ -f "$file" ]; then
			_formatter $file;
		else
			echo "Not a file: $file"
		fi
	done
  fi
  # when path is directory
  if [ -d $1 ];then
	find $1 $maxdepth $depth -type f -not \( -name "*.pyc" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.h" -o -name "*.c" \) | while read -r line
	do _formatter $line; done
  fi
}


### The following part is added to integrate with PyCharm's External Tools function easily.
# check if the script is sourced or executed directly
(
  [[ -n $ZSH_VERSION && $ZSH_EVAL_CONTEXT =~ :file$ ]] ||
  [[ -n $KSH_VERSION && "$(cd -- "$(dirname -- "$0")" && pwd -P)/$(basename -- "$0")" != "$(cd -- "$(dirname -- "${.sh.file}")" && pwd -P)/$(basename -- "${.sh.file}")" ]] ||
  [[ -n $BASH_VERSION ]] && (return 0 2>/dev/null)
) && sourced=1 || sourced=0

# run formatter function for all arguments if the script is executed directly.
# If the script is sourced, the following will not be running.
if [ $sourced = "0" ]
then
  formatter "$@";
  set -e;
fi
