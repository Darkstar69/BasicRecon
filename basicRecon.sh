#!/usr/bin/env bash

ask_choice(){
	read -p "Install $1 (y/n) => " choice
	if [[ "$choice" == "y" ]] || [[ "$choice" == "Y" ]]; then
		return 0
	else
		return 1
	fi
}

run_subfinder(){
	if [[ ! $(command -v subfinder) ]]; then
		if ask_choice "subfinder"; then
			go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
			[ "$?" -eq 0 ] && echo "Installation finished"
		fi
	else
		subfinder -d "$1" -o result_subfinder.txt
	fi
				
}

subdomains_collection(){
	domain=$1
	run_subfinder $domain
	
}

