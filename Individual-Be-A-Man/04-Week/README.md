# Class 7 Week 4 Be A Man Challenge

Phase 1: Building the Network Foundation (VPC, Subnets, Gateways & Routes)
We will use the "VPC and more" wizard to create the entire network stack in one efficient operation.
1. Navigate to the VPC Dashboard.
Log in to the AWS Management Console.
In the top search bar, type VPC and select it from the services list.
Ensure you are in your preferred region in the top-right corner (e.g., N. Virginia (us-east-
1) , Ohio (us-east-2) ). The region must have at least three Availability Zones (AZs).
2. Launch the VPC Wizard.
On the VPC dashboard, click the large orange button that says "Create VPC".
Under "Resources to create," select "VPC and more". This powerful tool will build everything
we need.
3. Configure the VPC Settings.
Name tag auto-generation: Give it a clear name, like My-Project-VPC . This will automatically
tag all created resources.
IPv4 CIDR block: You can leave the default 10.0.0.0/16 . This is the private IP address range
for your entire network.
Number of Availability Zones (AZs): Select 3 from the dropdown. This is a critical
requirement.
Number of public subnets: Select 1 . We only need one public subnet for our bastion host.
Number of private subnets: Select 3 . This will create one private subnet in each of the three
AZs for our web servers.
NAT gateways: Select "In 1 AZ". This is a cost-effective way to allow our private instances to
access the internet for updates without being accessible from the internet.
VPC endpoints: Leave as "None".
DNS options: Ensure "Enable DNS hostnames" and "Enable DNS resolution" are both
checked.
4. Review and Create.
At the bottom right, you'll see a preview diagram and a list of all resources that will be created
(VPC, 4 subnets, 2 route tables, 1 Internet Gateway, 1 NAT Gateway).
Click "Create VPC".
This process will take a few minutes as AWS provisions the NAT Gateway. Once complete, you
will have a fully functional network foundation.
Phase 2: Defining Security Rules (Security Groups)
Security groups act as virtual firewalls. We need two: one for the public bastion and one for the private
web servers.
1. Navigate to Security Groups.
In the left-hand navigation pane of the VPC dashboard, under "Security," click "Security
Groups".
2. Create the Bastion Host Security Group.
Click "Create security group".
Name: Bastion-SG
Description: Allows RDP access to the Windows Bastion host
VPC: Select your My-Project-VPC from the dropdown.
Under "Inbound rules," click "Add rule":
Type: RDP
Protocol: TCP
Port range: 3389
Source: My IP . AWS will auto-detect your current public IP address. This is crucial for
security.
Leave "Outbound rules" as the default (allow all).
Click "Create security group".
3. Create the Web Server Security Group.
Click "Create security group" again.
Name: WebServer-SG
Description: Allows HTTP from public and SSH from the Bastion
VPC: Select your My-Project-VPC .
Under "Inbound rules," add two rules:
Rule 1 (for web traffic):
Type: HTTP
Source: Anywhere-IPv4 ( 0.0.0.0/0 )
Rule 2 (for SSH access from the bastion):
Type: SSH
Source: Start typing Bastion-SG and select the security group you just created. This
rule means only instances within the Bastion-SG can SSH into instances in this group.
Click "Create security group".
Phase 3: Launching the Windows Bastion Host
This is our secure gateway into the private network.
1. Navigate to the EC2 Dashboard and click "Launch instance".
2. Name: Windows-Bastion-Host
3. Application and OS Images (AMI): Select Microsoft Windows. Choose an AMI like "Microsoft
Windows Server 2022 Base".
4. Instance type: Select t2.micro or t3.micro (Free Tier eligible).
5. Key pair (login):
Click "Create new key pair".
Name: My-Project-Key
Key pair type: RSA
Private key file format: .pem
Click "Create key pair". Your browser will download the My-Project-Key.pem file. GUARD
THIS FILE. YOU CANNOT DOWNLOAD IT AGAIN.
6. Network settings:
Click "Edit".
VPC: Select My-Project-VPC .
Subnet: CRITICAL! Select the public subnet. Its name will be something like My-Project-
VPC-subnet-public1-us-east-1a .
Auto-assign public IP: Ensure this is Enabled.
Firewall (security groups): Select "Select existing security group" and choose Bastion-SG .
7. Leave storage and advanced details as default. Click "Launch instance".
Phase 4: Launching the Linux Web Servers
We will launch three servers, one by one, each with a unique web page.
Web Server 1 (in AZ 'a')
1. Navigate to the EC2 Dashboard and click "Launch instance".
2. Name: Linux-WebServer-A
3. AMI: Select Amazon Linux. Choose an AMI like "Amazon Linux 2023 AMI".
4. Instance type: t2.micro or t3.micro .
5. Key pair: Select the My-Project-Key you created earlier.
6. Network settings:
Click "Edit".
VPC: Select My-Project-VPC .
Subnet: CRITICAL! Select the first private subnet. It will be named something like My-
Project-VPC-subnet-private1-us-east-1a . Make sure it's in the first AZ ( ...1a ).
Auto-assign public IP: Ensure this is Disabled. Private instances do not get public IPs.
Firewall (security groups): Select "Select existing security group" and choose WebServer-SG .
7. Advanced details (User Data):
Expand the "Advanced details" section and scroll to the bottom.
In the User Data text box, paste the following script. This script runs on first boot, installs a web
server, and creates a unique webpage.
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
AZ=$(curl -s http://169.254.169.254/latest/meta-
data/placement/availability-zone)
echo "<html><body><h1>Hello from Web Server A!</h1><h2>Availability Zone:
$AZ</h2><br><img
src='https://assets.editorial.aetnd.com/uploads/2012/11/lion-king-
gettyimages-168381898.jpg' width='600'></body></html>" >
/var/www/html/index.html
8. Click "Launch instance".
Web Server 2 & 3 (in AZ 'b' and 'c')
Repeat the exact same steps above twice more with these specific changes:
For Web Server 2:
Name: Linux-WebServer-B
Subnet: Choose the second private subnet (e.g., ...-private2-us-east-1b ).
User Data: Use this modified script (different text and image):
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
AZ=$(curl -s http://169.254.169.254/latest/meta-
data/placement/availability-zone)
echo "<html><body><h1>Greetings from Web Server B!</h1>
<h2>Availability Zone: $AZ</h2><br><img
src='https://upload.wikimedia.org/wikipedia/en/thumb/9/98/Timon_and_Pu
mbaa_logo.svg/1200px-Timon_and_Pumbaa_logo.svg.png' width='600'>
</body></html>" > /var/www/html/index.html
For Web Server 3:
Name: Linux-WebServer-C
Subnet: Choose the third private subnet (e.g., ...-private3-us-east-1c ).
User Data: Use this final script:
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
AZ=$(curl -s http://169.254.169.254/latest/meta-
data/placement/availability-zone)
echo "<html><body><h1>Welcome from Web Server C!</h1><h2>Availability
Zone: $AZ</h2><br><img src='https://lumiere-
a.akamaihd.net/v1/images/p_thelionking_19752_1_22b46761.jpeg'
width='600'></body></html>" > /var/www/html/index.html
Phase 5: Connecting and Verification
This is where we take our screenshots.
1. Connect to the Windows Bastion Host.
In the EC2 console, select the Windows-Bastion-Host instance and click "Connect".
Go to the RDP client tab.
Click "Get password".
Click "Upload private key file" and select the My-Project-Key.pem file you downloaded.
Click "Decrypt Password". Copy and save the revealed password.
Use a Remote Desktop client on your computer to connect to the Public DNS address of the
bastion, using the username Administrator and the decrypted password.
2. Screenshot 1: The Running Windows Bastion Host.
Once you are logged into the Windows desktop via RDP, take a screenshot of the full desktop.
3. Prepare for SSH from the Bastion.
Inside your RDP session on the Windows bastion, open a text editor like Notepad.
On your local computer, open the My-Project-Key.pem file with a text editor.
Copy the entire contents of the .pem file.
Paste the key into the Notepad window on the bastion and save the file to the Desktop as My-
Project-Key.pem .
Download and install an SSH client on the bastion, such as PuTTY.
4. SSH into Each Linux Server.
Go to the EC2 Console and get the Private IPv4 addresses for each of the three Linux servers
(e.g., 10.0.11.x , 10.0.12.x , 10.0.13.x ).
For each server:
Open PuTTY (or your preferred SSH client) on the bastion.
In the "Host Name" field, enter the Private IP of the Linux server (e.g., ec2-
user@10.0.11.x ).
In PuTTY, navigate to Connection -> SSH -> Auth -> Credentials . Click "Browse"
and select the My-Project-Key.pem file from the Desktop. You may need to convert the
.pem to .ppk using PuTTYgen first.
Click "Open". Accept the security alert about the host key.
You should now have a successful SSH session.
5. Screenshot 2: Successful SSH Connections.
Arrange the three successful SSH terminal windows on the bastion's desktop so they are all
visible. Take one screenshot showing all three successful connections.
6. Screenshot 3, 4, 5: The Linux Web Servers.
Go to the EC2 console. For each of the three Linux servers, select it and find its Private IPv4
address.
From the Windows bastion host, open a web browser (like Edge).
In the address bar, type http:// followed by the Private IP of Linux-WebServer-A . You
should see its unique page.
Take a screenshot. In the screenshot, also include the EC2 console window in the
background, clearly showing that Linux-WebServer-A is in the first AZ (e.g., us-east-
1a ). This satisfies the "highlighting the AZ" requirement.
Repeat this process for Linux-WebServer-B and Linux-WebServer-C , taking a separate
screenshot for each that shows its unique webpage and its corresponding AZ in the console.
You have now completed all requirements.