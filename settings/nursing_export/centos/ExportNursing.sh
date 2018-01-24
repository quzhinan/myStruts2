#!/bin/sh

source /usr/local/ienursing2_cron/setenv.conf
$JAVA_HOME/bin/java jp.iesolutions.ienursing.batch.ExportNursingJob
