try_connection () {
    username=$1
    password=$2
    database=$3

    /opt/mssql-tools/bin/sqlcmd -S localhost -U $username -P $password -d $database 2>/dev/null
    return $?
}

execute_sql_file () {
    username=$1
    password=$2
    filename=$3

    /opt/mssql-tools/bin/sqlcmd -S localhost -U $username -P $password -d master -i $filename && return 0
    return 1
}

# DATA INPUT #
#   1->SA_USERNAME
#   2->SA_PASSWORD
#   3->ADMIN_USERNAME
#   4->ADMIN_PASSWORD
# -- #


CONNECTION_STATUS=0
SA_USERNAME=$1
SA_PASSWORD=$2
ADMIN_USERNAME=$3
ADMIN_PASSWORD=$4

echo "Starting context-builder..."

echo "Prepping context..."
sed -i "s/__ADMIN__/$ADMIN_USERNAME/g; s/__PASSWORD__/$ADMIN_PASSWORD/g" create-context.sql

echo "Displaying context..."
cat create-context.sql

echo "Waiting for Sql Server to be online..."
while [ $CONNECTION_STATUS -ne 1 ]
do
    try_connection $SA_USERNAME $SA_PASSWORD "master" && CONNECTION_STATUS=1
    sleep 5s
done
echo "Server Online!"

echo "Building data..."
execute_sql_file $SA_USERNAME $SA_PASSWORD create-context.sql && echo "\tCreated context!"
execute_sql_file $SA_USERNAME $SA_PASSWORD data-builder.sql && echo "\tCreated data!"