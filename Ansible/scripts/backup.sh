#!/bin/sh

# configuration
FILE=backup.sql.`date +"%Y%m%d"`
DBSERVER=127.0.0.1
DATABASE=project
USER=root
PASS={{ mysql_root_password }}
FOLDER=/home/ec2-user/backup

# create folder
mkdir -p ${FOLDER}

# backup commands
mysqldump --opt --user=${USER} --password=${PASS} ${DATABASE} > ${FOLDER}/${FILE}

# compress file
gzip -f ${FOLDER}/${FILE}

# delete older backups than 5 days
cd ${FOLDER} && ls -tp | grep -v '/$' | tail -n +6 | xargs -I {} rm -- {}

# print when done
echo "${FOLDER}/${FILE}. was created:"
ls -l ${FOLDER}