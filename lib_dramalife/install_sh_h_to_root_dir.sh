#! /bin/bash


#DES_PATH_TO_INSTALL="~/.note_wjy_lib_sh"
DES_PATH_TO_INSTALL="./sssss"


# CMD_W_MKDIR="mkdir ${DES_PATH_TO_INSTALL}"
# CMD_W_CP_SH="cp ./*.sh ${DES_PATH_TO_INSTALL}/"
# 
# echo ${CMD_W_MKDIR}
# echo ${CMD_W_CP_SH}
# 
# exec ${CMD_W_MKDIR}
# exec ${CMD_W_CP_SH}

sudo cp ./*.h /usr/local/include/
sudo cp ./*.sh /usr/bin/
