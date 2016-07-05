#!/bin/bash
askURL(){
  condition1=true
  while $condition1
  do
    read -p "Please enter the Stream URL:" streamURL
	lsreturn=$(livestreamer "$streamURL")
	if [ `echo $lsreturn | grep -c "No plugin can handle URL"` -gt 0 ]
      then
        echo "Livestreamer cant handle this URL. Please try again"
      elif [ `echo $lsreturn | grep -c "No streams found on this URL"` -gt 0 ]
        then
	      echo "Wrong URL or Stream is offline. Please try again"
      else
	    condition1=false
	fi
  done
}
askQ(){
  quality=${lsreturn##*'Available streams:'}
  qlist=$(echo $quality | tr "," "\n")
  qlist="${qlist//(worst)/ }"
  qlist="${qlist//(best)/ }"
  qlist="${qlist// /}"
  qArray=()
  for q in $qlist
    do
      qArray+=($q)
    done
  
  condition2=true
  while $condition2
    do
	  echo "Choose one of the following qualities!"
	  counter=0;
	  for q in "${qArray[@]}"
		do
		  echo "#$counter: $q"
		  counter=$(($counter+1))
	  done
	  read -p "#?" qChoice
	  if [ $qChoice -lt 0 ] || [ $qChoice -gt $((${#qArray[@]}-1)) ]
		then
		  echo "No valid quality, please choose the right number"
		else
		  condition2=false
		  streamQ=${qArray[$qChoice]}
	  fi
	done
}
startStream(){
  livestreamer --config "./.config.default" "$streamURL" "$streamQ"
}

askURL
askQ
startStream

condition3=true
while $condition3
  do
  echo "What next?"
  echo "#1: restart stream"
  echo "#2: change quality"
  echo "#3: change URL"
  echo "#4: Quit"
  read -p "?" choice2
  if [ $choice2 -eq 1 ]
    then
      startStream
  elif [ $choice2 -eq 2 ]
	then
	  askQ
      startstream
  elif [ $choice2 -eq 3 ]
    then
	  askURL
	  askQ
	  startStream
  elif [ $choice2 -eq 4 ]
    then
	  condition3=false
  else
    echo "Not a valid choice. Try again"
  fi
done