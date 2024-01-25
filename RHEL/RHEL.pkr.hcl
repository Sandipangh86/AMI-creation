source "amazon-ebs" "rhel8" {
    source_ami = ami-05c8ca4485f8b138a

}
ami_name        =   "Sandipan-AMI"
instance_type   =   "t3.2xlarge"
region          =   "ap-south-1"
vpc_id          =   vpc-03339c28de1d32314
subnet_id       =   subnet-0f1509aa8f464ecd3
ena_support     =   "true"
launch_block_device_mappings    {
    device_name =   "/dev/sad1"
    volume_type =   "gp3"
    delete_on_termination   = "true"
    volume_size =   80
}