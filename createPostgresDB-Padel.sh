#!/bin/bash

# Define PostgreSQL connection parameters
DB_USER="postgres"
DB_PASSWORD="This1sSecure"
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="padel"

# Path to your SQL scripts
CREATE_TABLES_001_SCRIPT="src/main/resources/config/liquibase/2023-03-10-001-createTables.sql"
CREATE_TABLES_002_SCRIPT="src/main/resources/config/liquibase/2023-03-10-002-createTables.sql"
CREATE_TABLES_003_SCRIPT="src/main/resources/config/liquibase/2023-03-10-003-createTables.sql"

CREATE_TABLES_003_SCRIPT="src/main/resources/config/liquibase/2023-03-10-003-createTables.sql"

INSERT_DATA_SCRIPT="path/to/insert_data.sql"

# Command to execute the SQL scripts
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f "$CREATE_TABLES_001_SCRIPT" &&
    psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f "$CREATE_TABLES_002_SCRIPT" &&
    psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f "$CREATE_TABLES_003_SCRIPT"

# Check if the create tables script executed successfully
if [ $? -eq 0 ]; then
    echo "Tables created successfully."
else
    echo "Error: Table creation failed."
    exit 1
fi

# Command to insert data
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f "$INSERT_DATA_SCRIPT"

# Check if the insert data script executed successfully
if [ $? -eq 0 ]; then
    echo "Data inserted successfully."
else
    echo "Error: Data insertion failed."
    exit 1
fi
