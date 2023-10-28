provider "aws" {
region = "us-west-1" # Replace with your desired region
}

# Create an EC2 instance
  resource "aws_instance" "example" {
    count = 1 # Change the count to the desired number of instances
    ami = "ami-019290fca71f9a776" # Replace with the desired AMI ID
    instance_type = "t2.micro"
    key_name = "my machine key pair"
    tags = {
    Name = "ubuntu-server-${count. index + 1}"
}

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, World!' > /home/ubuntu/hello.txt",
    ]
  }
}
  output "public_ip" {
    value = aws_instance.example[*].public_ip
}