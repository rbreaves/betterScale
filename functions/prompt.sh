#!/usr/bin/env bash

distro=$(awk -F= '$1=="NAME" { print tolower($2) ;}' /etc/os-release | tr -d \'\")
destring=$("./functions/dename.sh")
IFS=', ' read -r -a dearray <<< "$destring"
dename=$(echo ${dearray[0]} | awk '{print tolower($0)}')
deversion=${dearray[1]}
distroversion=$(lsb_release -sr)

function isnum() { awk -v a="$1" 'BEGIN {print (a == a + 0)}'; }

function running() { echo -e "${BYELLOW}$1${NC}"; }
function ransuccess() { echo -e "${BGREEN}$1${NC}"; }
function ranfailure() { echo -e "${BRED}$1${NC}"; }

function canary() {
	if [ $1 -eq 0 ]; then
		echo -e "${BGREEN}$2${NC}"
	else
		echo -e "${BRED}$3${NC}"
		return 1
	fi
}

# Do not give users multiple choices that start with the same letter.
# Use numbers if you need to. This is intended to be a simple prompt & answer.
function prompt(){
	# $1 - Question
	# $2 - array of choices
	choices="$2"
	defaultKey=""
	answerKeys=()
	showKeys=""
	# Set default key and keyboard input keys
	for i in "${choices[@]}"; do
		if [ "${i:0:1}" == "*" ]; then
			newKey+="${i:1}"
			defaultKey="${newKey:0:1}"
			answerKeys+="$(tr [a-z] [A-Z] <<< "${newKey:0:1}")""$(tr [A-Z] [a-z] <<< "${newKey:0:1}")"
			if [ "$(tr [a-z] [A-Z] <<< "${i:1:1}")" == "a" ];then
				showKeys="[${BGREEN}A${NC}]ll/${showKeys}"
			else
				showKeys="${BGREEN}$(tr [a-z] [A-Z] <<< "${i:1:1}")${NC}/"
			fi
		else
			answerKeys+="$(tr [a-z] [A-Z] <<< "${i:0:1}")""$(tr [A-Z] [a-z] <<< "${i:0:1}")"
			if [ "$(tr [a-z] [A-Z] <<< "${i:0:1}")" == "a" ];then
				showKeys+="[a]ll/"
			else
				showKeys+=$(tr [A-Z] [a-z] <<< "${i:0:1}")
			fi
		fi
	done

	IFS=@
	while true; do
		if [ ${#1} -gt 0 ]; then
			question=$1' '
		else
			question=$1
		fi
		read -rep "${BWHITE}$question${NC}[$showKeys]" response
			case "@${answerKeys[*]}@" in
					(*"$response"*) response="$(tr [A-Z] [a-z] <<< $response)";break;;
			esac
	done

	if [ "$response" == "" ]; then
		response="$defaultKey"
	fi
	echo "$response"
}