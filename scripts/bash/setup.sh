#This script creates a new scratch org, deploys all metadata, opens the org, and then assigns the
#cron string permission set
#
#Requires first argument of scratch org name
sf org create scratch --edition developer -a cron_string_builder -d 
sf project deploy start
sf org assign permset --name Cron_String_Permission_Set
read -p "Press Enter to exit..."
