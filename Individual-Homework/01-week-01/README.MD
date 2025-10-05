## BAMC 1.1

    In the EC2 console select the running EC2 instance named My-HTTP-Server.    
    - Select under Actions, Image and templates, Create template from instance.
   
   ![template-menu](/Individual-Homework/03-week-03/graphics/aws-ec2-create-template-menu-screenshot.png)

    - Input a name for the template. In this example we will name the template HW01-BAMC-Template.

    - Launch template name: HW01-BAMC-Template.

    - Template version description: HW01-BAMC-Template.

    - Template Tags: Add creation date to help keep track of when the template was created.


    ![AWS-EC2-Create-Launch-Template](/Individual-Homework/03-week-03/graphics/aws-ec2-create-launch-template.png)


    In the Advanced section select user data perform the following steps:
    - Clear the current content in the user data field.
    - Copy the content from the modified ec2script file in BAMC-1.1/ec2script-1.1.txt.
    - Clear the User data section and input the content from the file BAMC-1.2/ec2script-1.2.txt.
        - Open the file and select "Copy Raw File" using the GitHub interface.
    - Save template.

    If everything worked then you should see a GREEN success message that you now have a template.

    

    Review the created template.
    - Select Launch templates from the left menu Instances > Launch Templates.       
    - You should see your newly created template.
    - Select the advanced tab and you should see your modified e2 script contents.

    Launch a new EC2 instance from the template.
    - Select actions > Launch instance from template.
    - Select under the Summary tab, Launch Instance.
    - You should see a GREEN successful EC2 launch.

    [NOTE] If you still have other EC2 instances running you will see your new EC2 instance running. Since it is running in the same VPC, your Security Group settings will control access to the EC2 instance.

    Verify changes to the web service running on the EC2 instance which has your modified index.html file.

    ![BMC1.1](/Individual-Homework/03-week-03/graphics/aws-ec2-bmc-1.1.png)
 
 ## BAMC 1.2
    
    For this version we will use the same procedures as above except we will modify the template.

    - Select EC2 > Launch Templates.
    - Select our existing Launch Template (e.g. HW01-BAMC-Template).
    - Select Actions, Launch Instance from template.
    - Open the Advanced details section at the bottom of the web page.
    - Clear the User data section and input the content from the file BAMC-1.2/ec2script-1.2.txt.
        - Open the file and select "Copy Raw File" using the GitHub interface.

        You should see your modified configuration for the index.html file.
    - Under Summary, select Launch Instance

    - Select the instance URL in the GREEN Successfully initiated launch of instance popup.

    - Verify your modification by selecting the Public DNS record and opening the URL in a new browser tab or window.

    ![BMC-1.2](/Individual-Homework/03-week-03/graphics/aws-ec2-bmc-1.2.png)

    [NOTE] You can and *should* use your own pictures to customize your test web page!

# Teardown Instructions

In any deployment on AWS we want to make sure we remove all objects we created. This is a good practice especially for proof of concept or demonstration projects like this one.

- Access the EC2 console and terminate any running instances.

- Select each running EC2 instance and select Instance State > Terminate Instances

![AWS Terminate EC2 Example](/Individual-Homework/03-week-03/graphics/aws-ec2-terminate-instance.png)

- Select the refresh icon to make sure all instances are terminated.

![AWS EC2 terminated](/Individual-Homework/03-week-03/graphics/aws-ec2-terminated-instances.png)

- Remove the Security Group we created for this demonstration.

- Network & Security > Security Groups
 - Select the security group we named SG-01 or whatever name you chose to use.

 [WARNING] DO NOT TOUCH the *default* security group of the VPC!!!

 ![AWS VPC Custom SG](/Individual-Homework/03-week-03/graphics/aws-vpc-custom-security-group.png)

- Refresh the window and you should see your original default VPC security group.

- Delete Launch Template
 - Instances > Launch Templates
 - Select the Launch Template ID that was created in previous steps. In this example that is HW01-BAMC-template.

 - Select Actions > Delete Template

 ![Delete-Template](/Individual-Homework/03-week-03/graphics/aws-ec2-template-delete.png)

 - In the Delete Launch Template menu you should read the note to understand that this is a irreversible action.

 - Input the confirmation word, and select Delete.

 ![delete template confirmation](/Individual-Homework/03-week-03/graphics/aws-ec2-template-delete-confirmation.png)

 If the deletion succeeded you should see a GREEN popup that states that the Deleet Launch Template Request succeeded. 

Return to your AWS EC2 Dashboard and refresh the web page.

In the Resources you should not see any Running Instances. You may see a number in Instances but those should match the instances you terminated.

As pictured below in the EC2 dashboard I have a quantity of 2 instances. Selecting the Instances shows that those match the last 2 instances that were terminated. You will notice in the screenshot that the dashboard shows no Instances in a *running* state.

![EC2 Dashboard](/Individual-Homework/03-week-03/graphics/ec2-dashboard-instance.png)


![EC2 Terminated Instances](/Individual-Homework/03-week-03/graphics/aws-ec2-terminated-instances.png)