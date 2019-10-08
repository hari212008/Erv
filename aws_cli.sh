#!/bin/bash

arr='InService Stopped'
declare -a Inservice_id

for i in $arr
do
   if [ $i == 'InService' ] 
   then
	InService_id=`aws sagemaker list-notebook-instances --status-equals $i | grep NotebookInstanceName`
   fi
   #echo $InService_id
   for j in $InService_id
   do	
	#echo $j
        #item_temp="${j%\"}"
	item=`echo $j | sed -e 's/^"//' | sed -e 's/",$//'`
	echo "$item"
	sleep 3
	if [ $j != '"NotebookInstanceName":' ]
	then
		stop =  `aws sagemaker stop-notebook-instance --notebook-instance-name $item`
		echo $stop
      	fi
   done
done
