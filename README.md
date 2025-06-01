# Salesforce DX Project: Next Steps

Cron String Builder is a simple component for building the schedule string requried to run scheduled jobs.  It can be dropped on any lightning page.

## Packaging Commands

> sf package create --name CronString --package-type Unlocked --path force-app
> sf package version create --package "CronString" --wait 10 --installation-key-bypass

Unlocked Packaging Workflow: https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_unlocked_pkg_workflow.htm
