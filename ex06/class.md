# Create instance
```
aws ec2 run-instances --image-id ami-0abcdef1234567890 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-0123456789abcdef0 --subnet-id subnet-6e7f829e
```

# Create instance
```
aws ec2 run-instances --image-id ami-04b4f1a9cf54c11d0 --count 1 --instance-type t2.micro --key-name experts-key --security-group-ids sg-0c6dc40043dfbf332 --subnet-id subnet-00ce5794449f278d5
```

# List instances
```
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].[InstanceId,PublicIpAddress,InstanceType,State.Name]" --output table
```

# IAM intro
Cloud creates a shared infra  with multiple consumers so limiting blast factors and providing identiy is ana ctual need

aws iam create-user --user-name checkuser

# CLI limitation and pros
|Pros|Cons|
---------------
|Quick access|no single source of truth for the state|
||Can't define complex relation of the resources|
