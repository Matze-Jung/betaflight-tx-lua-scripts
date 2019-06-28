#!/bin/bash

MINIFY=$1
ERRCNT=0

if [ -d obj ]; then
    rm -fR obj/*
else
    mkdir obj
fi

if [ -d tmp ]; then
    rm -dfR tmp
fi

mkdir -p tmp/SCRIPTS/BF
echo
luac -v

if [[ $MINIFY == "min" ]]; then
    echo
    echo luamin $(npm view luamin version)"  "Copyright Mathias Bynens [https://github.com/mathiasbynens/luamin]
fi

echo
echo "duplicating ..."
## backup minify excludes
EXCLUDE=(`find src/SCRIPTS/BF/* -name *pre.lua -type f`);
for x in ${EXCLUDE[@]};
do
    mkdir -p $(dirname ${x/src/tmp})
    cp -fR $x ${x/src/tmp}
done
cp -fR src/SCRIPTS/BF/X7/exmpl1.lua tmp/SCRIPTS/BF/X7/exmpl1.lua

MANIFEST=(`find src/* -name *.lua -type f`);

if [ ${#MANIFEST[@]} -eq 0 ]; then
    echo -e "\e[1m\e[39m[\e[31mTEST FAILED\e[39m] \e[21mNo scripts could be found\e[21m!"
    exit 1
fi

rm -f tmp/tmperr
touch tmp/tmperr

echo "building ..."

for file in ${MANIFEST[@]};
do
    SRC_PATH=$(dirname ${file})/
    OBJ_PATH=${SRC_PATH/src/obj}
    OBJ_LUA=$(basename ${file})
    OBJ_LUAC=${OBJ_LUA/.lua/.luac}

    echo
    echo -ne "\e[1m\e[37m${file}\e[39m\e[1m\e[0m ...\e[0m"

    mkdir -p ${OBJ_PATH}

    if [[ $MINIFY == "min" ]]; then
        echo -n " minify ..."
        node node_modules/luamin/bin/luamin -f "$file" > "${OBJ_PATH}${OBJ_LUA}"
        cp -f "${file/src/tmp}" "${OBJ_PATH}${OBJ_LUA}" >/dev/null >tmp/null 2>tmp/null
    else
        cp -f "$file" "${OBJ_PATH}${OBJ_LUA}"
    fi

    echo -n " compile ..."
    luac -s -o "${OBJ_PATH}${OBJ_LUAC}" "$file" >tmp/tmpvar 2>tmp/tmpvar
    STDOUT=$(<tmp/tmpvar)
    rm -f tmp/tmpvar

    _fail=$?
    if [[ $_fail -ne 0 || $STDOUT ]]; then
        ((ERRCNT++))
        echo
        echo `date +"%Y-%m-%d %T"` "$file $STDOUT"$'\r' >>tmp/tmperr
        echo -e "\e[1m\e[39m[\e[31mBUILD FAILED\e[39m] \e[1m \e[0m\e[37mCompilation error:\e[0m"
        echo -e "\e[1m\e[37m${STDOUT}\e[39m\e[1m\e[0m \e[0m"
    else
        echo -ne " \e[1m\e[39m[\e[32mok\e[39m]\e[1m\e[0m\e[0m"
    fi
done
echo

LAST_FAILURES=$(<tmp/tmperr)

rm -dfR tmp

if [[ $LAST_FAILURES == '' ]]; then
    echo
    echo "copying attachments..."
    cp -fvR src/SOUNDS obj/SOUNDS

    echo
    echo -e "\e[1m\e[39m[\e[32mSUCCESSFUL\e[39m] \e[21mAll lua files built successfully!\e[21m\e[1m\e[0m\e[0m"
else
    echo "$LAST_FAILURES"$'\r' >> ".builderr"
    echo
    echo -e "\e[1m\e[39m[\e[31mBUILD FAILED\e[39m] \e[1m \e[0m\e[37mCompilation error(s):\e[0m"
    echo -e "\e[1m\e[37m${LAST_FAILURES}\e[39m\e[1m\e[0m \e[0m"$'\r'
fi

echo
exit $ERRCNT
