#!/bin/sh

if [ "$1" = 'asadmin' ]; then
    if [ "$AS_ADMIN_PASSWORD" ]; then
        echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd
        echo "AS_ADMIN_NEWPASSWORD=${AS_ADMIN_PASSWORD}" >> /tmp/glassfishpwd

        # Change the admin password
        asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1

        if [ "$AS_ADMIN_ENABLE_SECURE" ]; then
            echo "AS_ADMIN_PASSWORD=${AS_ADMIN_PASSWORD}" > /tmp/glassfishpwd
            asadmin start-domain
            asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin
            asadmin stop-domain
        fi

        rm /tmp/glassfishpwd
    fi

    exec "$@"
fi

exec "$@"
