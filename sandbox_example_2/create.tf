/*
Copyright (c) 2023 Cisco and/or its affiliates.

This software is licensed to you under the terms of the Cisco Sample
Code License, Version 1.1 (the "License"). You may obtain a copy of the
License at

               https://developer.cisco.com/docs/licenses

All use of the material herein must be in accordance with the terms of
the License. All rights not expressly granted by the License are
reserved. Unless required by applicable law or agreed to separately in
writing, software distributed under the License is distributed on an "AS
IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
or implied.
*/



# Use Case 2: Create new system feature template and read multiple available 
# feature templates to create and attach a new device template

#Define and create new system FEATURE TEMPLATE. Set up multiple variables.
resource "sdwan_cisco_system_feature_template" "TF_system_template" {
  name               = "TF_system_template"
  description        = "Test bootstrap system template"
  device_types       = ["vedge-C8000V"]
  system_ip_variable = "var_system_ip"
  hostname_variable  = "var_hostname"
  site_id_variable   = "var_site_id"
  longitude          = -130
  latitude           = 40
  console_baud_rate = "9600"
  }

#Read available FEATURE TEMPLATES.
data "sdwan_cisco_logging_feature_template" "Factory_Default_Cisco_Logging_Template" {
  id = "34f5afa8-a6b9-4465-9cab-001324a70ff3"
}

data "sdwan_cisco_omp_feature_template" "Factory_Default_Cisco_OMP_ipv46_Template" {
  id = "a28f93ef-72e3-4445-96a4-f061dbca9091"
}

data "sdwan_cedge_aaa_feature_template" "Factory_Default_AAA_CISCO_Template" {
  id = "5c64dac5-2c0e-4ea3-9ce1-e2727307f532"
}

data "sdwan_cisco_bfd_feature_template" "Factory_Default_Cisco_BFD_Template" {
  id = "7ef8f7c8-3291-490b-85b2-e87f6006295c"
}

data "sdwan_cisco_security_feature_template" "Factory_Default_Cisco_Security_Template" {
  id = "f960808c-b1b6-4f55-a2b2-5d4ace477310"
}

data "sdwan_cisco_vpn_feature_template" "DC_VPN_0_cEdge_Template_v1" {
  id = "2ee186d6-6686-48ef-97f6-bb456250fb2f"
}

data "sdwan_cisco_vpn_interface_feature_template" "DC_VPN_0_MPLS_Template_v1" {
  id = "0eabec13-ac79-4a48-aed4-bd056faa870a"
}

data "sdwan_cisco_vpn_interface_feature_template" "DC_VPN_512_cEdge_Template_v1" {
  id = "c47c1006-3c8a-473f-bd47-dc957c5b6f75"
}

data "sdwan_cedge_global_feature_template" "Factory_Default_Global_CISCO_Template" {
  id = "56e134b4-71e3-46a2-9c53-7ba10ec2ca3e"
}

#Define and create new DEVICE TEMPLATE referencing the above feature templates
resource "sdwan_feature_device_template" "TF_device_template" {
  name        = "TF_DT"
  description = "My device template via terraform. Using new and available feature templates."
  device_type = "vedge-C8000V"
  device_role = "sdwan-edge"
  general_templates = [{
    id      = sdwan_cisco_system_feature_template.TF_system_template.id
    type    = sdwan_cisco_system_feature_template.TF_system_template.template_type
    version = sdwan_cisco_system_feature_template.TF_system_template.version
  },
  { id      = data.sdwan_cisco_logging_feature_template.Factory_Default_Cisco_Logging_Template.id
    type    = data.sdwan_cisco_logging_feature_template.Factory_Default_Cisco_Logging_Template.template_type
    version = data.sdwan_cisco_logging_feature_template.Factory_Default_Cisco_Logging_Template.version
  },
  { id      = data.sdwan_cedge_aaa_feature_template.Factory_Default_AAA_CISCO_Template.id
    type    = data.sdwan_cedge_aaa_feature_template.Factory_Default_AAA_CISCO_Template.template_type
    version = data.sdwan_cedge_aaa_feature_template.Factory_Default_AAA_CISCO_Template.version
  },
  { id      = data.sdwan_cisco_omp_feature_template.Factory_Default_Cisco_OMP_ipv46_Template.id
    type    = data.sdwan_cisco_omp_feature_template.Factory_Default_Cisco_OMP_ipv46_Template.template_type
    version = data.sdwan_cisco_omp_feature_template.Factory_Default_Cisco_OMP_ipv46_Template.version
  },
  { id      = data.sdwan_cisco_bfd_feature_template.Factory_Default_Cisco_BFD_Template.id
    type    = data.sdwan_cisco_bfd_feature_template.Factory_Default_Cisco_BFD_Template.template_type
    version = data.sdwan_cisco_bfd_feature_template.Factory_Default_Cisco_BFD_Template.version
  },
  { id      = data.sdwan_cisco_security_feature_template.Factory_Default_Cisco_Security_Template.id
    type    = data.sdwan_cisco_security_feature_template.Factory_Default_Cisco_Security_Template.template_type
    version = data.sdwan_cisco_security_feature_template.Factory_Default_Cisco_Security_Template.version
  },
  { id      = data.sdwan_cisco_vpn_feature_template.DC_VPN_0_cEdge_Template_v1.id
    type    = data.sdwan_cisco_vpn_feature_template.DC_VPN_0_cEdge_Template_v1.template_type
    version = data.sdwan_cisco_vpn_feature_template.DC_VPN_0_cEdge_Template_v1.version
    sub_templates = [{
              id      = data.sdwan_cisco_vpn_interface_feature_template.DC_VPN_0_MPLS_Template_v1.id
              type    = data.sdwan_cisco_vpn_interface_feature_template.DC_VPN_0_MPLS_Template_v1.template_type
              version = data.sdwan_cisco_vpn_interface_feature_template.DC_VPN_0_MPLS_Template_v1.version
            }]
  },
  { id      = data.sdwan_cisco_vpn_interface_feature_template.DC_VPN_512_cEdge_Template_v1.id
    type    = data.sdwan_cisco_vpn_interface_feature_template.DC_VPN_512_cEdge_Template_v1.template_type
    version = data.sdwan_cisco_vpn_interface_feature_template.DC_VPN_512_cEdge_Template_v1.version
  },
  { id      = data.sdwan_cedge_global_feature_template.Factory_Default_Global_CISCO_Template.id
    type    = data.sdwan_cedge_global_feature_template.Factory_Default_Global_CISCO_Template.template_type
    version = data.sdwan_cedge_global_feature_template.Factory_Default_Global_CISCO_Template.version
  }
  ] 
}

#Attach DEVICE TEMPLATE to device and provide values for multiple variables
resource "sdwan_attach_feature_device_template" "custom_attach" {
  id      = sdwan_feature_device_template.TF_device_template.id
  version = sdwan_feature_device_template.TF_device_template.version
  devices = [{
    id = "C8K-E2D91A30-814B-F22D-4E7B-7D39BE74EE32"
    variables = {
      var_system_ip = "10.10.1.11"
      var_site_id   = "105"
      var_hostname  = "terraform_dc-cedge01_2"
      vpn_512_next_hop_ip_address = "10.10.20.254"
      vpn_0_next_hop_ip_address = "10.10.23.5"
      public_internet_0_vpn_next_hop_ip_addres = "10.10.23.37"
      vpn_0_if_description = "GigabitEthernet2.wan-rtr01"
      vpn_0_if_name = "GigabitEthernet2"
      vpn_0_if_ipv4_address = "10.10.23.6/30"
    }
  }]
}

# Use Case 3: Change feature template and device attachment values
