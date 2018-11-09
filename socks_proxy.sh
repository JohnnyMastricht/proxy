
#!/bin/bash
source ../proxy_servers
	case $1 in
	    LA | La | la | lA)
		  PID=$(lsof -i:$proxyport | grep ssh | awk {'print $2'} | uniq )
		  if [ -d /proc/$PID/cwd ]; then echo -e "It seems that the connection is already established. Exiting..."
		  	else
			    read -p "Enter login:" login
			    echo "calling Mephistopheles of Los Angeles..."
        		ssh -f -C2qTnN -D $proxyport $login@$laserver -p$sshport
        		if [ $? -eq 0 ]; then echo "The connection has been established"
                else 
                	echo "Something went wrong during the connection process"
                fi
          fi
	;;
	    LY | Ly | ly | lY)
          PID=$(lsof -i:$proxyport | grep ssh | awk {'print $2'} | uniq )
		  if [ -d /proc/$PID/cwd ]; then echo -e "It seems that the connection is already established. Exiting..."
		     else
               read -p "Enter login:" login
			   echo "calling Lithuania server..."
			   ssh -f -C2qTnN -D $proxyport $login@$lyserver -p$sshport
			    if [ $? -eq 0 ]; then echo "The connection has been established"
                 else 
                  echo "Something went wrong during the connection process"
                fi
          fi
	;;
		close)
			PID=$(lsof -i:$proxyport | grep ssh | awk {'print $2'} | uniq )
			if [ -d /proc/$PID/cwd ]; then kill -9 $PID && echo -e "Connection has been terminated successfully"
			else echo "Something went wrong! Please check manually."
	        fi
	;;
		status)
			PID=$(lsof -i:$proxyport | grep ssh | awk {'print $2'} | uniq )
			if [ -d /proc/$PID/cwd ]; then echo -e "Socks proxy should be running on port 1080 with PID '$PID'"
			else echo "Seems that Socks proxy is not running"
	        fi
	;;
	    *)
			echo "Possible options are: ly| la | close | status"
esac