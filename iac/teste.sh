#!/bin/bash

echo "a SHELL eh $SHELL"
# aws sts get-caller-identity

aws glue get-database --name default >/dev/null

if [ $? -eq 0 ]
then
    echo "o database existe...vou tentar conceder as permissoes"
    aws lakeformation grant-permissions --cli-input-json file://templates/grant-permissions.tpl
else
    echo "o database nao existe...vou tentar criar"
    aws glue create-database --database-input file://templates/create-database.tpl
fi

