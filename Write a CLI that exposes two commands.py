import argparse
import boto3

def list_files(args):
    # create an S3 client
    s3 = boto3.client('s3')

    # specify the name of the bucket
    bucket_name = args.bucket_name

    # list the objects in the bucket
    objects = s3.list_objects(Bucket=bucket_name)

    # print the names of the objects
    for obj in objects['Contents']:
        print(obj['Key'])

def list_task_def(args):
    # create an ECS client
    ecs = boto3.client('ecs')

    # specify the name of the service
    service_name = args.service_name

    # list the task definition revisions for the service
    revisions = ecs.list_task_definition_revisions(serviceName=service_name)

    # print the arn and createdAt of the task definition revisions
    for revision in revisions['taskDefinitionRevisions']:
        print(f'Task Definition ARN: {revision["taskDefinitionArn"]}')
        print(f'Created At: {revision["createdAt"]}')

parser = argparse.ArgumentParser(description='Simple CLI')
subparsers = parser.add_subparsers(help='commands')

# create the parser for the "list_files" command
parser_list_files = subparsers.add_parser('list_files', help='list files in an S3 bucket')
parser_list_files.add_argument('bucket_name', help='name of the S3 bucket')
parser_list_files.set_defaults(func=list_files)

# create the parser for the "list_task_def" command
parser_list_task_def = subparsers.add_parser('list_task_def', help='list versions of the ECS task definition for a service')
parser_list_task_def.add_argument('service_name', help='name of the ECS service')
parser_list_task_def.set_defaults(func=list_task_def)

# parse the args and call the appropriate function
args = parser.parse_args()
args.func(args)
