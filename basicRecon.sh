#!/usr/bin/env bash

exit_script(){
	read -p "\nSure want to exit (y/n) ? => " input
	if [[ "$input" == "y" ]] || [[ "$input" == "Y" ]]; then
		echo "Cleaning up...."
		exit 0
	else
		continue
	fi
}

ask_choice(){
	read -p "Install $1 (y/n) => " choice
	if [[ "$choice" == "y" ]] || [[ "$choice" == "Y" ]]; then
		return 0
	else
		return 1
	fi
}

run_subfinder(){
	domain=$1
	if [[ ! $(command -v subfinder) ]]; then
		if ask_choice "subfinder"; then
			go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
			[ "$?" -eq 0 ] && echo "Installation finished" && run_subfinder "$domain"
		fi
	else
		subfinder -d "$domain" -o result_subfinder.txt
	fi
				
}

run_assetfinder(){
	domain=$1
	if [[ ! $(command -v assetfinder) ]]; then
		if ask_choice "assetfinder"; then
			sudo apt install assetfinder
			[ "$?" -eq 0 ] && echo "Installation finished" && run_assetfinder "$domain"
		fi
	else
		assetfinder -subs-only "$domain" > result_assetfinder.txt
	fi
}


run_sublist3r(){
	domain=$1
	if [[ ! $(command -v sublist3r) ]]; then
		if ask_choice "sublist3r"; then
			sudo apt install sublist3r
			[ "$?" -eq 0 ] && echo "Installation finished" && run_sublist3r "$domain"
		fi
	else
		sublist3r -d "$domain" -o result_sublist3r.txt
	fi

}



subdomains_collection(){
	read -p "Enter domain => " domain
#	run_subfinder $domain
#	run_assetfinder $domain
#	run_sublist3r $domain
	
}

main(){
	while true;
	do
		subdomains_collection
		sleep 1		
	done
}

main
