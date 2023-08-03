
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Host Out of Memory (OOM) Incident
---

A Host Out of Memory(OOM) Incident occurs when a server or system runs out of memory, causing it to crash or become unresponsive. This can be caused by a variety of factors, such as an unexpected surge in traffic or insufficient resources allocated to the system. Resolving this type of incident requires identifying the root cause of the memory issue and taking appropriate measures such as optimizing system resources or increasing memory capacity.

### Parameters
```shell

```

## Debug

### Check the amount of free memory
```shell
free -m
```

### Check the amount of used memory by each process
```shell
ps aux --sort=-%mem | head
```

### check the journalctl logs for any out of memory errors
```shell
journalctl | grep -i "Out of memory"
```

### Check the garbage collector logs for any errors
```shell
dmesg | grep -i "out of memory"
```

### Check the process limits for the user running the process
```shell
ulimit -a
```

### Check the system limits for the amount of memory available
```shell
sysctl -a | grep mem
```

### Check the kernel logs for any memory-related errors
```shell
grep -i "out of memory" /var/log/kern
```

### Check the swap usage on the host
```shell
swapon -s
```

### The host may be running too many applications or processes simultaneously, causing excessive memory usage.
```shell
#!/bin/bash



# Define threshold for memory usage

THRESHOLD=80



# Get current memory usage

CURRENT_USAGE=$(free | awk '/^Mem:/{print $3/$2 * 100.0}')



# Check if current usage exceeds threshold

if (( $(echo "$CURRENT_USAGE > $THRESHOLD" | bc -l) )); then

    # List processes by memory usage

    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11

fi
```

# Note
---

Before you proceed with changing the instance type, please be aware that the current instance will restart during the process. Changing the instance type involves stopping the current instance, resizing its resources, and then starting it again with the new configuration.

### Changing AWS Instance type Using AWS CLI
```shell
aws ec2 modify-instance-attribute --instance-id <your_instance_id> --instance-type <new_instance_type>


```

### Change the size of an Azure VM Using the Azure CLI
```shell
az vm resize --resource-group <resource_group_name> --name <vm_name> --size <new_vm_size>


```

### Changing the Machine type in GCP
```shell
gcloud compute instances set-machine-type <instance_name> --machine-type <new_machine_type> --zone <zone>
```

### In Kubernetes, you can change the memory resources for a pod's containers using the kubectl command-line tool. There are two common ways to achieve this: by updating the pod's YAML manifest file or by using kubectl edit.
```shell
kubectl edit pod <pod_name>
```