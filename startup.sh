#!/bin/bash

scriptPath="$(cd "$(dirname "$0")"; pwd)/$(basename "$0")"
dir=`dirname "$scriptPath"`

#get location file params
if [ -z "$step2" ]; then
	echo "Input the File Param (ex. /params.properties)"
	read ParamsFile
else
	ParamsFile=$step2
fi


if [ -z $ParamsFile ]; then
	ParamsFile="$dir/params.properties"
	echo "Default File params location choosed : $ParamsFile"
else
	echo "Selected location : $ParamsFile"
fi

#cd /API
chmod +x $dir/API/API_run.sh


#run job
echo ""
echo "****************** running job ******************"

$dir/API/API_run.sh $ParamsFile