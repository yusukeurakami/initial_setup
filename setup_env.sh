#!/bin/zsh

function copy_formatter_setting {
    ABS_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    FORMAT_SETTING_FILE=${ABS_PATH}/scripts/pyproject_for_local_format.toml
    cp ${FORMAT_SETTING_FILE} ${HOME}/.local/
}

function update_shrc {
    ABS_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    SCRIPT_DIR=${ABS_PATH}/scripts

    # update the script names
    FILES=("format.sh")

    # rm -rf ${SCRIPT_DIR}/*.sh

    for f in "${FILES[@]}"
    do
        script=${SCRIPT_DIR}/$f
        echo $script
        grep "source ${script}" ${SHRC} && \
        sed -i 's/${script}/${cmd}/g' ${SHRC} || \
    	    echo "source ${script}" >> ${SHRC}
    done
}

if [ -n "$ZSH_VERSION" ]; then
    echo "zsh version $ZSH_VERSION"
    SHRC=${HOME}/.zshrc
else
    echo -e "\033[031mzsh not found!\033[0m"
    exit -1
fi

update_shrc
copy_formatter_setting
