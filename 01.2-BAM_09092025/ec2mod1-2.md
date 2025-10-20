#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Background the curl requests
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)

echo "
<!doctype html>
<html lang=\"en\" class=\"h-100\">
<head>
<title>Details for EC2 instance</title>
</head>
<body class="bgimg">
<div>
<h1>AWS Instance Details</h1>
<h1>Samurai Katana</h1>

<br>
<img src="https://dahhalc2h3amq3.archive.is/mqYQQ/235521b20bec386f27fffdc6f40cdd69f2e8b7be.webp" alt="Cute">

 <style>
    body,h1,h3 {font-family: "Raleway", sans-serif}
    body, html {height: 100%}
    .bgimg {
      background-image: url('https://www.nicepng.com/png/detail/82-821445_philippines-japan-classnk-jsmea-philippine-flag-and-japan.png');
      min-height: 100%;
      background-position: center;
      background-size: cover;
    }
</style>
<br>

<b> I, Futurist2099, Thank Theo And Million_S, For Teaching Me About Ec2s In Aws. One Step Closer To Escaping Keisha! With This Class, I Will Net 150k Per Year!

I found my wife on a party yacht in Asia! Her name is Sayuri! </b>

<!-- https://www.instagram.com/watanabemika/  --> 
<br>

<p><b>Instance Name:</b> $(hostname -f) </p>
<p><b>Instance Private Ip Address: </b> ${local_ipv4}</p>
<p><b>Availability Zone: </b> ${az}</p>
<p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>
</div>
</body>
</html>
" > /var/www/html/index.html

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid

