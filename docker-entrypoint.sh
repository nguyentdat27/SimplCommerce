#!/bin/bash
set -e
export PGPASSWORD=superman6969

if psql -h postgres --username postgres -lqt | cut -d \| -f 1 | grep -qw simplcommerce; then
    echo "simplcommerce database existed"
else
    echo "create new database simplcommerce"
    psql -h postgres --username postgres -c "CREATE DATABASE simplcommerce WITH ENCODING 'UTF8'"
    psql -h postgres --username postgres -d simplcommerce -a -f /app/dbscript.sql
fi

cd /app && dotnet SimplCommerce.WebHost.dll
