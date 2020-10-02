 param (
                [string]$Environmenttype
				
)
 
 switch ($Environmenttype) {

 aws { $Action=read-host -Prompt "1- List AWS Profiles`n2- Add AWS Profile" 
 
 switch ($Action){
 
 1 {(Get-AWSCredential -ListProfileDetail  -ProfileLocation $HOME\Desktop\aws_cred|select ProfileName)
 
    }
 2 {
 
 ($AccessKey=read-host -Prompt "Please Enter AccessKey")
 ($Profile_Name=read-host  -Prompt "Please Enter Profile Name")
 ($SecretKey=read-host Prompt "Please Enter SecretKey" )
 (Set-AWSCredential -StoreAs $Profile_Name -AccessKey $AccessKey -SecretKey $SecretKey -ProfileLocation $HOME\Desktop\aws_cred)
  
 }
 
  
  
 
 }
 
 
 
 }
 
 vmware { $Action=read-host -Prompt "1- List VMware Profiles`n2- Add VMware Profile" 
 
 switch ($Action){
 
 1 {
     (Get-VICredentialStoreItem -File $HOME\desktop\vmware_cred |select @{N="ProfileName";E={$_.user}})
    }
 2 {
	($Server=read-host -Prompt "Please Enter ESXI or vCenter IP/FQDN")
	($UserName=read-host -Prompt "Please Enter UserName")
	($Password=read-host  -Prompt "Please Enter Password")
    (New-VICredentialStoreItem -Host "$Server" -User "$UserName" -Password "$Password" -File "$HOME\desktop\vmware_cred")
 }
 
 
 
 }
 
 
 
 
 }
 
 }
 
 
 
 
 
 