# =============================================================================
# wget_mod.sh Version 1.4
# A script to aid in the use of the wget command. This script will format
# script output and streamline user input. This script will assume the folder
# $working_directory/wget_mod/ is present on the computer and it contains the folder /logs/.
#
# Things to add: Choose existing directories.
# =============================================================================
#!/bin/bash
line="
===============================================================================
"
line_short="========================================================="
loop=y
url=""
ua="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"
echo "\n"
echo "Welcome to the modified wget script."
echo "Type Q or q at any prompt to quit."
echo "\n"
echo $line_short
while test $loop = "y"
do
  echo "\n"
  echo "Enter the folder name for output."
  read directory
    case $directory in
      [Qq]) clear ; exit ;
            ;;
    esac
  echo "\n"
  echo "Enter the URL you wish to lookup."
  read url
    case $url in
      [Qq]) clear ; exit ;
            ;;
    esac
  echo "\n"
  echo "Would you like to change the User Agent (y/n)?"
  read change_ua
    case $change_ua in
      [Yy]) echo "Enter the new User Agent:" ;
            read ua ;
            echo "\n" ;
            ;;
      [Nn]) echo "\n" ;
            ;;
    esac
  # Add support for other option manipulations here
  echo "Would you like to continue (y/n)?"
  read keep_going
    case $keep_going in
      [Yy]) echo "\n";
            ;;
      [Nn]) clear ; exit ;
            ;;
      [Qq]) clear ; exit ;
            ;;
    esac
  # Prep oytput dir
  mkdir output/$directory
  cd output/$directory
  # Do the get
  echo "Wget is running....."
  wget -e robots=off -E -H -k -K -p -S -o ../../logs/wget_output_temp.log --save-cookies ../../logs/wget_cookies_temp.log --keep-session-cookies --no-check-certificate --follow-ftp -U "$ua" "$url"  # Use strong qoutes to preserve URL format
  echo "Wget is finished."
  cd ../../logs
  # Perform log file formatting
  echo "\n" >> wget_cookies.log
  echo $line >> wget_cookies.log
  date >> wget_cookies.log
  echo $line >> wget_cookies.log
  echo "\n" >> wget_cookies.log
  echo "\n" >> url.log
  echo $line >> url.log
  date >> url.log
  echo $line >> url.log
  echo "\n" >> url.log
  # Log and clean up temp output
  now=`date '+%Y%m%d%H%M%S'`
  cat wget_cookies_temp.log >> wget_cookies.log
  cat wget_output_temp.log >> $now-$directory-wget_output.log
  echo $url >> url.log
  rm wget_cookies_temp.log
  rm wget_output_temp.log
  cd ..
  # Go again or quit
  echo "\n"
  echo "Press [Qq] to quit or Enter to continue."
  read another_one
    case $another_one in
      [Qq]) echo "\n" ; exit ;
            ;;
    esac
done
