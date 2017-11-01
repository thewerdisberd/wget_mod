# =============================================================================
# wget_mod.sh Version 1.3
# A script to aid in the use of the wget command. This script will format
# script output and streamline user input. This script will assume the folder
# ~/wget/ is present on the computer and it contains the folder /logs/.
#
# Things to add: Choose existing directories.
# =============================================================================
#!/bin/bash
line="
===============================================================================
"
line_short="========================================================="
loop=y
naptime=1
url=""
ua="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"
# Perform some file formatting
cd ~/wget/logs/
echo $line >> wget_output.log
date >> wget_output.log
echo $line >> wget_output.log
echo $line >> wget_cookies.log
date >> wget_cookies.log
echo $line >> wget_cookies.log
echo $line >> url.log
date >> url.log
echo $line >> url.log
cd ~/wget/
while test $loop = "y"
do
  clear
  tput cup 1 3; echo "Welcome to the modified wget script"
  tput cup 2 3; echo "Type Q or q at any prompt to quit"
  tput cup 3 3; echo $line_short
  tput cup 4 3; echo "Enter the directory you would like webpage output to be"
  tput cup 5 3; echo "stored. All folders will be place in the default folder, "
  tput cup 6 3; echo "~/wget/. This may delete existing folders..."   # This option  overrides existing directories
  tput cup 8 3;
  read directory
    case $directory in
      [Qq]) clear ; exit ;
            ;;
    esac
  mkdir $directory
  cd $directory
  sleep $naptime
  tput cup 10 3; echo "Enter the URL you wish to lookup."
  tput cup 11 3; echo "Be sure to include the protocol specifier."
  tput cup 13 3;
  read url
    case $url in
      [Qq]) clear ; exit ;
            ;;
    esac
  echo $url >> ~/wget/logs/url.log
  sleep $naptime
  tput cup 15 3; echo "The default User Agent is 'Mozilla/5.0 (Windows NT 6.1; "
  tput cup 16 3; echo "WOW64; Trident/7.0; rv:11.0) like Gecko'."
  tput cup 17 3; echo "This mimics a Windows computer using Internet Explorer."
  tput cup 19 3; echo "Would you like to change the User Agent (y/n)?"
  tput cup 20 3;
  read change_ua
    case $change_ua in
      [Yy]) tput cup 22 3; echo "Enter the new User Agent:" ;
            tput cup 23 3;
            read ua
            ;;
      [Nn]) tput cup 22 3; echo $line_short ;
            tput cup 23 3; echo $line_short ;
            ;;
    esac
  sleep $naptime
  tput cup 25 3; echo "Would you like to continue (y/n)?"
  tput cup 27 3;
  read keep_going
    case $keep_going in
      [Yy]) tput cup 29 3;
            ;;
      [Nn]) clear ; exit ;
            ;;
      [Qq]) clear ; exit ;
            ;;
    esac
  tput cup 29 3; echo "Wget is running....."
  wget -e robots=off -E -H -k -K -p -S -o ~/wget/logs/wget_output_temp.log --save-cookies ~/wget/logs/wget_cookies_temp.log --keep-session-cookies --no-check-certificate --follow-ftp -U "$ua" "$url"  # Use strong qoutes to preserve URL format
  tput cup 31 3; echo "Press [Qq] to quit or Enter to continue."
  tput cup 33 3;
  read another_one
    case $another_one in
      [Qq]) clear ; cd ~/wget/wget_mod/; ./wget_cleanup.sh ; exit ;
            ;;
    esac
done
