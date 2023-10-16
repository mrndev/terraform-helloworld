# terraform-helloworld
Terraform example that can be used as a starting point for more complex configurations. This example creates a virtual datacenter (VDC) and adds one VM into it and connects it into internet. The script assumes that it is run in Linux like environment (ssh pubkey available in ~/.ssh)

In order to run this example, you need to have the IONOS_* credentials or better, the IONOS_TOKEN environment variable set. The example below uses the IONOS_TOKEN. It is good practice to start to use the token from the start.

<pre>
~/$ <b>cd terraform-helloworld</b>
~/terraform-helloworld$ <b>export IONOS_TOKEN=xxx</b>
~/terraform-helloworld$ <b>terraform init</b>
~/terraform-helloworld$ <b>terraform apply</b>

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # ionoscloud_datacenter.myvdc will be created
  + resource "ionoscloud_datacenter" "myvdc" {
      + cpu_architecture = (known after apply)
      + description      = "My Virtual Datacenter created with Terraform"

  <i>... lots of output ...</i>

myserver_ip_address = <b>"217.160.221.218"</b>

~/terraform-helloworld$ <b>ssh root@217.160.221.218</b>  
<i>inside my newly created VM!...</i>

</pre>

# Useful links
- Terraform provider documentation https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs
