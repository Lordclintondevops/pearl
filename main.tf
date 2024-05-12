# Configuring my Provider
provider "aws" {
    region = var.region
  
}

#Creating an instance
resource "aws_instance" "jenkins" {
    ami = var.ami
    instance_type = "t3.large"

    user_data = <<-EO
    sudo apt-get update
    sudo apt-get install git maven -y
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \ https://pkg.jenkins.io/debian/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \ https://pkg.jenkins.io/debian binary/ | sudo tee \ /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins
    EO

    tags = {
      Name = "Jenkins"
    }
  
}