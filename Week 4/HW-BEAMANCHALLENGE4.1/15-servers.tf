# Application Servers (one in each private subnet)
# Application Server 1
resource "aws_instance" "app_server_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private-eu-west-1a.id
  vpc_security_group_ids = [aws_security_group.app1-sg01-servers.id]
  key_name = data.aws_key_pair.MyWindows.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              echo "<html>
                      <body>
                        <h1>Server 1 - Mustafar Volcano</h1>
                        <p>Welcome to Server 1 running in eu-west-1a</p>
                        <img src='https://lumiere-a.akamaihd.net/v1/images/mustafar-main_fb0a08e5.jpeg' width='400' alt='Mustafar'>
                      </body>
                    </html>" > /var/www/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
  
  tags = {
    Name    = "app-server-1"
    Service = "application1"
    Be-A-Man = "Week4"
    Challenge-Number = "4.1"
  }
}

# Application Server 2
resource "aws_instance" "app_server_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private-eu-west-1b.id
  vpc_security_group_ids = [aws_security_group.app1-sg01-servers.id]
  key_name = data.aws_key_pair.MyWindows.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              echo "<html>
                      <body>
                        <h1>Server 2 - Tatooine Desert</h1>
                        <p>Welcome to Server 2 running in eu-west-1b</p>
                        <img src='https://lumiere-a.akamaihd.net/v1/images/tatooine-main_954d7512.jpeg' width='400' alt='Tatooine'>
                      </body>
                    </html>" > /var/www/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
  
  tags = {
    Name    = "app-server-2"
    Service = "application1"
    Be-A-Man = "Week4"
    Challenge-Number = "4.1"
  }
}

# Application Server 3
resource "aws_instance" "app_server_3" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private-eu-west-1c.id
  vpc_security_group_ids = [aws_security_group.app1-sg01-servers.id]
  key_name = data.aws_key_pair.MyWindows.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              echo "<html>
                      <body>
                        <h1>Server 3 - Hoth Ice Planet</h1>
                        <p>Welcome to Server 3 running in eu-west-1c</p>
                        <img src='https://lumiere-a.akamaihd.net/v1/images/hoth-main_04c6c8ac.jpeg' width='400' alt='Hoth'>
                      </body>
                    </html>" > /var/www/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
  
  tags = {
    Name    = "app-server-3"
    Service = "application1"
    Be-A-Man = "Week4"
    Challenge-Number = "4.1"
  }
}