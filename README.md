# GVE DevNet SD-WAN Terraform

Collection of sample code examples around the template feature of Cisco Catalyst SD-WAN Manager (formerly Cisco SD-WAN vManage).

## Use Cases:
1. **Attach an existing device template:** see sandbox_example_1 folder
![/IMAGES/workflow1.png](/IMAGES/workflow1.png)

2. **Create and attach a new feature and device template:** see sandbox_example_2 folder
![/IMAGES/workflow2.png](/IMAGES/workflow2.png)

3. **Update the template values and variables of an attached device:** see sandbox_example_2 folder
![/IMAGES/workflow3.png](/IMAGES/workflow3.png)


## Contacts
* Ramona Renner


## Solution Components
* [Cisco Catalyst SD-WAN Sandbox](https://devnetsandbox.cisco.com/RM/Diagram/Index/ed2c839d-621e-4c55-b176-db2457baf4c8?diagramType=Topology) (see instructions below)
* [Cisco Catalyst SD-WAN Terraform Provider](https://registry.terraform.io/providers/CiscoDevNet/sdwan)


## Related Sandbox Environment

This sample code is built specifically for the [Cisco SD-WAN 20.10 Sandbox](https://devnetsandbox.cisco.com/RM/Diagram/Index/ed2c839d-621e-4c55-b176-db2457baf4c8?diagramType=Topology). 
For use with other environments, it is required to adapt the code accordingly since it refers to specific template/device IDs and names available in the mentioned sandbox environment.


## Installation/Configuration

### Install Terraform

The project uses [Terraform](https://www.terraform.io) and was tested with version v1.5.3. Navigate to the [Terraform Documentation](https://developer.hashicorp.com/terraform/downloads) and follow the instructions to install Terraform on your preferred platform.

Use the command **terraform -v** to validate the Terraform version after installation.


### Book and Connect to the Sandbox

Navigate to the [Cisco SD-WAN 20.10 page](https://devnetsandbox.cisco.com/RM/Diagram/Index/ed2c839d-621e-4c55-b176-db2457baf4c8?diagramType=Topology) and click **Reserve** in the top-right corner. Select the preferred schedule and press the **Reserve** button. The setup typically takes around 15 minutes. During the setup process and after successful completion, you are informed via email.

Note the IP address, port, username and password for HTTPS provided in the **Credentials** tab of the sandbox page for a later step.

Connect to the sandbox VPN based on the instructions and credentials provided in the success email. 


### Prepare the Sandbox Device 

This sample code was tested with the device **dc-cedge01** in the sandbox. The mentioned device is attached to a device template by default. Before we can attach a template via Terraform to the device, it is required to detach the device. 

Therefore, open Cisco Catalyst SD-WAN Manager and follow the below steps:   
Open the **Menu** >   
Click the **Configuration** menu element >    
Click the **Templates** menu element >    
Click the **Device Templates** tab >    
Click the three dots in the row of the **DC_cEdge_Template** >     
Select **Detach devices** >     
Move the device **dc-cedge01** to the **Selected devices'** list >    
Press **Detach** and wait for the task status to change to **Success**.


### Prepare and Execute Terraform Sample Code

1. Clone this GitHub repository into a local folder:  
    ```
    git clone [add GitHub link here]
    ```
  * Or simply download the repository as zip file using the **Download ZIP** button and extract it


2. Access the downloaded folder:  
    ```
    cd gve_devnet_sdwan_terraform
    ```

3. Fill in the URL and credentials of the sandbox in the global/outputs.tf file.

    ```
    output "sdwan_username" {
        value     = "<Cisco Catalyst SD-WAN account username>"
        sensitive = true
    }

    output "sdwan_password" {
        value     = "<Cisco Catalyst SD-WAN account password>"
        sensitive = true
    }

    output "sdwan_url" {
        value     = "<Cisco Catalyst SD-WAN url, e.g. https://x.x.x.x:port>"
        sensitive = true
    }
    ```

**For each sandbox_example_x folder separately:**
 
4. Access the folder for the preferred use case. The use cases are described in more detail at the beginning of this page.  
    ```
    cd sandbox_example_<x>
    ```

    > Note: The terraform examples interfer with each other - please revert the changes made by one use case before executing the other use case. Reverting the changes is for example possible by using the command ```terraform destroy```.


5. Initialize Terraform. The [init command](https://developer.hashicorp.com/terraform/cli/commands/init) performs several different initialization steps in order to prepare the current working directory for use with Terraform. 
    ```
    terraform init
    ```


6. (Optional) Create a Terraform execution plan. The terraform [plan command](https://developer.hashicorp.com/terraform/cli/commands/plan) creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. 
    ```
    terraform plan
    ```


7. Apply the terraform changes. The terraform [apply command](https://developer.hashicorp.com/terraform/cli/commands/apply) executes the actions proposed in the Terraform plan. When running the command below, an execution plan is created as part of the process. Approve the plan when prompted. 
    ```
    terraform apply
    ```

## Demo

View before and after statuses in Cisco Catalyst SD-WAN Manager on the following pages:

* Templates View: Open the **Menu** > Click the **Configuration** menu element > Click the **Templates** menu element > Click the **Templates** tab of the preferred template type
* Devices Configuration View: Open the **Menu** > Click the **Configuration** menu element > Click **Devices**
* Devices Monitor View: Open the **Menu** > Click the **Monitor** menu element > Click **Devices** > Click on the hostname of the preferred device for more details



# Screenshots

![/IMAGES/screenshot.png](/IMAGES/screenshot.png)

### LICENSE

Provided under Cisco Sample Code License, for details see [LICENSE](LICENSE.md)

### CODE_OF_CONDUCT

Our code of conduct is available [here](CODE_OF_CONDUCT.md)

### CONTRIBUTING

See our contributing guidelines [here](CONTRIBUTING.md)

#### DISCLAIMER:
<b>Please note:</b> This script is meant for demo purposes only. All tools/ scripts in this repo are released for use "AS IS" without any warranties of any kind, including, but not limited to their installation, use, or performance. Any use of these scripts and tools is at your own risk. There is no guarantee that they have been through thorough testing in a comparable environment and we are not responsible for any damage or data loss incurred with their use.
You are responsible for reviewing and testing any scripts you run thoroughly before use in any non-testing environment.