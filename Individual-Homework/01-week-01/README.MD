# BAM Template deployment Instructions

These are the instructions to create a template of a running EC2 instance, modify the templates user-data and deploy on AWS.

## BAMC 1.1

    In the EC2 console select the running EC2 instance named My-HTTP-Server.    
    - Select under Actions, Image and templates, Create template from instance.
   
   ![template-menu](/Individual-Homework/01-week-01/graphics/aws-ec2-create-template-menu-screenshot.png)


- Input a name for the template. In this example we will name the template HW01-BAMC-Template.  
    
    - Launch template name: HW01-BAMC-Template.

        - Template version description: HW01-BAMC-Template.

        - Template Tags: Add creation date to help keep track of when the template was created.
    
    ![AWS-EC2-Create-Launch-Template](/Individual-Homework/01-week-01/graphics/aws-ec2-create-launch-template.png)


- In the Advanced section select user data perform the following steps:

    - Clear the current content in the user data field.
    - Copy the content from the modified ec2script file in ec2-scripts-textfiles/ec2script-1.1.txt.
    - Clear the User data section and input the content from the file ec2-scripts-textfiles/ec2script-1.2.txt.
    - Open the file and select "Copy Raw File" using the GitHub interface.
    - Save template.

    If everything worked then you should see a GREEN success message that you now have a template.

    

- Review the created template.
    - Select Launch templates from the left menu Instances > Launch Templates.       
    - You should see your newly created template.
    - Select the advanced tab and you should see your modified e2 script contents.

    Launch a new EC2 instance from the template.
    - Select actions > Launch instance from template.
    - Select under the Summary tab, Launch Instance.
    - You should see a GREEN successful EC2 launch.

    [NOTE] If you still have other EC2 instances running you will see your new EC2 instance running. Since it is running in the same VPC, your Security Group settings will control access to the EC2 instance.

    Verify changes to the web service running on the EC2 instance which has your modified index.html file.

![BMC1.1](/Individual-Homework/01-week-01/graphics/aws-ec2-bmc-1.1.png)
 
 ## BAMC 1.2
    
- For this version we will use the same procedures as above except we will modify the template.

    - Select EC2 > Launch Templates.
    - Select our existing Launch Template (e.g. HW01-BAMC-Template).
    - Select Actions, Launch Instance from template.
    - Open the Advanced details section at the bottom of the web page.
    - Clear the User data section and input the content from the file ec2-scripts-textfiles/ec2script-1.2.txt.
        - Open the file and select "Copy Raw File" using the GitHub interface.

        You should see your modified configuration for the index.html file.
    - Under Summary, select Launch Instance

    - Select the instance URL in the GREEN Successfully initiated launch of instance popup.

    - Verify your modification by selecting the Public DNS record and opening the URL in a new browser tab or window.

    ![BMC-1.2](/Individual-Homework/01-week-01/graphics/aws-ec2-bmc-1.2.png)
