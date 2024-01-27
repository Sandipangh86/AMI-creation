source "amazon-ebs" "hello-ec2" {
    region =  "ap-south-1"
    source_ami_filter {
        filters =   {
            virtualization-type =   "hvm"
            root-device-type    =   "ebs"
            name    =   "RHEL-8.6.0*"
        }
        owners  =   ["309956199498"]
        most_recent =   "true"
    }

ami_name        =   "sandipan-packer_AWS {{timestamp}}"
instance_type   =   "t3.2xlarge"
#region          =   "ap-south-1"
iam_instance_profile    =   "sandipan_iam"
vpc_id          =   "vpc-03339c28de1d32314"
subnet_id       =   "subnet-0f1509aa8f464ecd3"
ena_support     =   "true"
launch_block_device_mappings    {
    device_name =   "/dev/sda1"
    volume_type =   "gp3"
    delete_on_termination   = "true"
    volume_size =   80
}
temporary_key_pair_type     = "ed25519"
ssh_username            =   "ec2-user"
associate_public_ip_address = true
ssh_interface           =   "session_manager"
session_manager_port    =   1600
communicator            =   "ssh"
ssh_timeout             =   "11m"
user_data_file          =   "user_data.sh"
}

build {
    sources  =   [
        "source.amazon-ebs.hello-ec2"
    ]
provisioner "shell" {
    inline = [
        "sudo useradd ssm-user",
        "sudo echo 'ssm-user    ALL=(ALL)   NOPASSWD:ALL'   >   /etc/sudoers.d/ssm-agent-users",
        "sudo chmod 440 /etc/sudoers.d/ssm-agent-users",
        "sudo yum install dialog -y"
    ]
}
}