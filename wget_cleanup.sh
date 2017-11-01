# =============================================================================
# wget_cleanup.sh Version 1.0
# Author: gothmog@email.tg
# A cleanup script for the wget_mod.sh script. This script adds temp log files
# to permanent log files wget_output.log and wget_cookies.log.
# =============================================================================
#!/bin/bash\
cd ~/wget/logs/
cat wget_cookies_temp.log >> wget_cookies.log
cat wget_output_temp.log >> wget_output.log
rm wget_cookies_temp.log
rm wget_output_temp.log
