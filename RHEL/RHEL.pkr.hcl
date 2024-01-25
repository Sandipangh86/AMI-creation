source "amazon-ebs" "rhel" {
    source_ami = ami-05c8ca4485f8b138a

ami_name        =   "Sandipan-AMI"
instance_type   =   "t3.2xlarge"
region          =   "ap-south-1"
vpc_id          =   "vpc-03339c28de1d32314"
subnet_id       =   "subnet-0f1509aa8f464ecd3"
ena_support     =   "true"
launch_block_device_mappings    {
    device_name =   "/dev/sad1"
    volume_type =   "gp3"
    delete_on_termination   = "true"
    volume_size =   70
}
temporary_key_pair_type =   "ed25519"
ssh_username            =   "ec2-user"
ssh_interface           =   "session_manager"
session_manager_port    =   1600
communicator            =   "ssh"
ssh_timeout             =   "10m"
user_data_file          =   "user_data.sh"
}

build {
    name    =   Sandipan-AMI
    source  =   ["source.amazon-ebs.rhel"]


provisioner "shell" {
    inline = [
        "sudo useradd ssm-user",
        "sudo echo 'ssm-user    ALL=(ALL)   NOPASSWD:ALL'   >   /etc/sudoers.d/ssm-agent-users",
        "sudo chmod 440 /etc/sudoers.d/ssm-agent-users",
        "sudo yum install dialog -y"
    ]
}
}