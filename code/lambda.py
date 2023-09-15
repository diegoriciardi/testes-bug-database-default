import boto3
import re


def criaClientGlue():
    glueClient = boto3.client('glue')
    print("client glue criado")
    return glueClient

def criaClientLakeFormation():
    lakeFormationClient = boto3.client('lakeformation')
    print("client lakeformation criado")
    return lakeFormationClient

def criaClientSTS():
    stsClient = boto3.client('sts')
    print("client sts criado")
    return stsClient

def checaDbGlueExists(database):
    glue_client = criaClientGlue()
    dbexists = False
    expected_exception = "EntityNotFoundException"

    try:
        response = glue_client.get_database(
            Name=f"{database}"
        )
        dbexists = True

    except Exception as e:
        print(e)
        regex_result = re.search(expected_exception, str(e))
        if regex_result != None:
            dbexists = False
    
    print(f"db {database} existe? : {dbexists}")
    return dbexists

def concedePermissaoDbExistente(database):
    
    sts_client = criaClientSTS()

    response = sts_client.assume_role(
        RoleArn="arn:aws:iam::438028509953:role/role-lf-admin",
        RoleSessionName="role-lf-admin"
    )

    lakeformation_client = boto3.client(
        'lakeformation',
        aws_access_key_id=response["Credentials"]["AccessKeyId"],
        aws_secret_access_key=response["Credentials"]["SecretAccessKey"],
        aws_session_token=response["Credentials"]["SessionToken"]
    )

    print(f"concedendo permissao IAM_ALLOWED_PRINCIPALS para db {database} existente")

    lakeformation_client.grant_permissions(
        Principal={
            "DataLakePrincipalIdentifier": "IAM_ALLOWED_PRINCIPALS"
        },
        Resource={
            "Database": {
                "Name": f"{database}"
            }
        },
        Permissions=[
            'ALL'
        ]
    )

def criaDbDefault(database):
    glue_client = criaClientGlue()

    print(f"criando database {database}")
       
    glue_client.create_database(
        DatabaseInput={
            "Name": f"{database}",
            "CreateTableDefaultPermissions": [
                {
                    "Principal": {
                        'DataLakePrincipalIdentifier': 'IAM_ALLOWED_PRINCIPALS'
                    },
                    'Permissions': [
                        'ALL'
                    ]
                }
            ]
        }
    )

def handler():
    print("inicio funcao principal")
    if checaDbGlueExists("default") == True:
        concedePermissaoDbExistente("default")
    else:
        criaDbDefault("default")

    print("fim funcao principal")
    

if __name__ == "__main__":
    handler()