# Postgres Backup for AWS Lambda
AWS Lambda function that copies a schema from one postgres database to another.

The function uses `pg_dump` and `pg_restore` to copy the contents of a postgres database schema to another database. The function can be used to copy a schema from a production database to a development database, or to copy a schema from a production database to a staging database. 

## Postgres version
Tested with postgres 14.5. To modify the function to work for another version of postgres, replace the files in the `bin` directory with the files from the postgres version you want to use.

## Running on AWS Lambda
Follow these steps to set up this function to run on AWS Lambda:
1. **Create a new lambda function from the AWS Management console:** For runtime, select "Provide your own bootstrap on Amazon Linux 2"
2. **Upload the contents of this directory as a .zip file:** `zip -r lambda.zip . -x \.git\*` then upload it via "Code > Code source > Upload from > .zip file" 
3. **Change the handler:** Under "Code > Runtime settings > Handler" change the handler to `handler.copyDb`
4. **Modify the function configuration:** Under "Configuration > General configuration", modify the timeout, memory and storage. You may need to play around with these values to find ones that work best, based on the size of the database you are copying.
5. **Set environment variables:** Under "Configuration > Environment variables", set `SOURCE_DB` and `TARGET_DB` to be the connection strings for the source database to copy from and target database to copy into respectively. Also set `SCHEMA` to be the schema you want to copy from the source database.

> Note: you will need to make sure that both the source and target databases are configured to allow access to the lambda function.

## Executing the function
The function can be executed by invoking the function manually via the console. Alternatively, you could set it up to run on a schedule using AWS EventBridge, or trigger it via an HTTP request by setting up an API Gateway endpoint.
