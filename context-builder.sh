echo "Starting context-builder..."
echo "Sleeping for 90s"

sleep 90s

echo "Starting to build context..."

/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P XFPMWJbc7XjFGc1KNJEnUCst1bTKN0et -d master -i create-context.sql