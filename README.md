## **PSNotification**
Powershell module to enable easy invocation of HTTP Endpoints used to enable notifications when a powershell execution is completed.

## **Getting started**
### **Install the latest module**
```
Install-Module -Name PSNotification
```

### **List all available commands / functions**

```
Get-Command -Module PSNotification
```

### **Update the module**

```
Update-Module -name PSNotification
```

## **Appetizers**

### **Configure default HTTP endpoint URL**

```
Set-PSNUrl -Url "https://prod-35.westeurope.logic.azure.com:443/workflows/14adfasdrae23354432636dsfasfdsaf/"
```

### **Have a long running process and want to get notified when done?**
```
Do-Stuff | Invoke-PSNMessage -Email "Claire@contoso.com" -Subject "Stuff was done"
```
**This will invoke the default URL for each output piped from the Do-Stuff cmdlet / function. This execution is synchronous and will block the execution until the HTTP endpoint responds.**

### **Want to be notified, but not block execution?**
```
Do-Stuff | Invoke-PSNMessage -Email "Claire@contoso.com" -Subject "Stuff was done" -AsJob
```
**This will invoke the default URL for each output piped from the Do-Stuff cmdlet / function. This execution is asynchronous and will start a background job that handles everything with the HTTP endpoint.**

