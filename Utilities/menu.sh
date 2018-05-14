#!/bin/bash

function yesno {
  dialog --stdout --title "Are you sure?" \
  --backtitle "PiAstro 1.1" \
  --yesno "Do you really want to execute $1 ?" 7 60
  return $?
}

function mydialog {
  dialog --title "PiAstro commands" --backtitle "PiAstro 1.1" --msgbox "$1" 0 0 
}

while true
do
 
  dialog --title "PiAstro commands" --backtitle "PiAstro 1.1" --menu "Choose..." 0 0 0\
  Uno uno\
  Due due\
  Tre tre\
  Exit "Exit from menu"\
  2>/tmp/menu.$$

  if [ $? -ne 0 ]
  then
    clear
    rm -rf /tmp/menu.$$
    exit
  fi

  OPT=`cat /tmp/menu.$$`

  rm -rf /tmp/menu.$$

  case "$OPT" in
        Uno)
            mydialog "$OPT"
            ;;
         
        Due)
            yesno $OPT
            if [ $? -eq 0 ]
            then
              mydialog "Sicuro?"
            fi
            ;;
         
        Tre)
            yesno $OPT
            if [ $? -eq 0 ]
            then
              mydialog "Proprio sicuro?"
            fi
            ;;
         
        *)
            mydialog "Hai scelto $OPT"
            clear
            exit 1
 
  esac
done
