param (
                [string]$Environmenttype
  
)


switch ($Environmenttype) {

aws{"welcome to AWS please select the need action"

$Action=read-host -Prompt "1- List AWS Regions `n2- List EC2 Instances `n3- Poweron_ec2_instance `n4- Poweroff_ec2_instance"
    
  
  ########### List of Aws Actions ################


    switch ($Action)
    { 1 {(Get-AWSRegion)}
      2 {
	  ($profile_name=read-host -Prompt "Enter AWS Profile Name");
	  ($Region_name=read-host -Prompt "Enter AWS Region Name");
	  ((Get-EC2Instance -ProfileName $profile_name -ProfileLocation $HOME\Desktop\aws_cred -Region $Region_name).Instances|select  InstanceId,PublicIpAddress,PrivateIpAddress,@{N="Powerstate";E={$_.state.name}})
	  
	  }
      
	  3 {
	    ($instanceid=Read-Host -Prompt "Enter Aws instanceid");
		($profile_name=read-host -Prompt "Enter AWS Profile Name");
		($Region_name=read-host -Prompt "Enter AWS Region Name");
		(Start-EC2Instance -ProfileName $profile_name -ProfileLocation $HOME\Desktop\aws_cred -Region $Region_name -InstanceId $instanceid)
		 }
      4 {
	    ($instanceid=Read-Host -Prompt "Enter Aws instanceid");
		($profile_name=read-host -Prompt "Enter AWS Profile Name");
		($Region_name=read-host -Prompt "Enter AWS Region Name");
		(Stop-EC2Instance -ProfileName $profile_name -ProfileLocation $HOME\Desktop\aws_cred -Region $Region_name -InstanceId $instanceid)
		}
    }
  ###################################################################################################################################

                              }

vmware{"welcome to vmware"

     $Action=read-host -Prompt "1- List VMs`n2- get vm by IP"

########### List of VMware Actions ################

switch ($Action)
    { 1 {
	
	     ($profile_name=read-host -Prompt "Enter VMware Profile Name");
         ($Profile=(Get-VICredentialStoreItem -File $HOME\Desktop\vmware_cred|where {$_.User -like "$profile_name"}));
		 (Connect-VIServer -Server $profile.Host -User $profile.User -Password $profile.Password);
         (Get-VM|select name,powerstate|ft -AutoSize)
		 }
		 
      2{
	  
	  ($IP=read-host -Prompt "Enter the IP");
	  ($profile_name=read-host -Prompt "Enter VMware Profile Name");
      ($Profile=(Get-VICredentialStoreItem -File $HOME\Desktop\vmware_cred|where {$_.User -like "$profile_name"}));
      (Connect-VIServer -Server $profile.Host -User $profile.User -Password $profile.Password);
	  (getvm_by-ip.ps1 -ip $IP)
	  
	  }
      
    }








######################################################################################################################################

}



hybrid{"welcome to Hybrid"

     $Action=read-host -Prompt "1- Copy_from_AWS_S3_to_VMware_Datastore"

########### List of Hybrid Actions ################

switch ($Action)
    { 1 {
	
	 ($profile_name=read-host -Prompt "Enter VMware Profile Name");
     ($Profile=(Get-VICredentialStoreItem -File $HOME\Desktop\vmware_cred|where {$_.User -like "$profile_name"}));
     (Connect-VIServer -Server $profile.Host -User $profile.User -Password $profile.Password);	
	 ($profile_name=read-host -Prompt "Enter AWS Profile Name");
	 ($BucketName=read-host -Prompt "Enter BucketName");
     ($Key=read-host -Prompt "Enter Object Name");
	 ($VM_Datastore=read-host -Prompt "Enter VMware Datastore");
	 ($vmstore=(get-datastore $VM_Datastore).DatastoreBrowserPath -replace "vmstores:","");
	 (copy-S3Object -ProfileName $profile_name -ProfileLocation $HOME\Desktop\aws_cred -BucketName $BucketName -Key files/$Key -LocalFolder $vmstore)}
      
    }
}





}
