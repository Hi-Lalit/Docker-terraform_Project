import boto3
import sys

ec2 = boto3.client('ec2')

def start_instance(instance_id):
    ec2.start_instances(InstanceIds=[instance_id])
    print(f"Starting instance: {instance_id}")

def stop_instance(instance_id):
    ec2.stop_instances(InstanceIds=[instance_id])
    print(f"Stopping instance: {instance_id}")

def get_status(instance_id):
    response = ec2.describe_instances(InstanceIds=[instance_id])
    state = response['Reservations'][0]['Instances'][0]['State']['Name']
    print(f"Instance {instance_id} status: {state}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python ec2_manager.py <start|stop|status> <instance_id>")
        sys.exit(1)

    action = sys.argv[1]
    instance_id = sys.argv[2]

    if action == "start":
        start_instance(instance_id)
    elif action == "stop":
        stop_instance(instance_id)
    elif action == "status":
        get_status(instance_id)
    else:
        print("Invalid action. Use start | stop | status")