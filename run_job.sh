#!/bin/bash

# Automatise the creation of the delivery ZIP
# version : 1.0
# Author : Hamza BOUDOUH 

# Project directory
step1=$1
projetFolder=""

# file params
step2=$2
ParamsFile=""

scriptPath="$(cd "$(dirname "$0")"; pwd)/$(basename "$0")"

dir=`dirname "$scriptPath"`

if [ -z "$step1" ]; then
	echo "Input the project folder (ex. /home/dev1/dev/TOS_DI-20181026_1147-V7.1.1/workspace/API_BD)"
	read projetFolder
else
	projetFolder=$step1
fi


if [ -z $projetFolder ]; then
	projetFolder="/home/dev1/dev/TOS_DI-20181026_1147-V7.1.1/workspace/API_BD"
	echo "Default Job location choosed : $projetFolder"
else
	echo "Selected location : $projetFolder"
fi

# packager Maven
echo ""
echo "****************** packaging du projet (mvn clean install) ******************"
mvn clean install -f $projetFolder"/poms/pom.xml"

# chemin du ZIP du Job builder avec maven
jobZipGenLocation=$projetFolder"/poms/jobs/process/API_started/api_0.1/target/api_0_1.zip"

# ajour de script startup.sh et le fichier de properties au zip du job
zip $jobZipGenLocation startup.sh params.properties

# extraction du zip générer
rm -rf $dir/MyJob
unzip $jobZipGenLocation -d $dir/MyJob

# Lancement du Job
chmod +x $dir/MyJob/startup.sh
$dir/MyJob/startup.sh











