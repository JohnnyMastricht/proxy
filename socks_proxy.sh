
#!/bin/bash
source ../proxy_servers
COMMAND="$1";
OPERATION="$2";
	case $COMMAND+$OPERATION in
	connect+LA | connect+La | connect+la | connect+lA)
			read -p "Enter login:" login
			echo "calling to Mephistopheles of Los Angeles..."
        		ssh -f -C2qTnN -D 1080 $login@$laserver -p2212
        		if [ $? -eq 0 ]; then echo "The connection has been established"
                else 
                	echo "Something went wrong during the connection process"
                fi
	;;
	connect+LY | connect+Ly | connect+ly | connect+lY)
            read -p "Enter login:" login
			echo "calling Lithuania server..."
			ssh -f -C2qTnN -D 1080 $login@$lyserver -p2212 && echo -e " '$?' - is the result of calling server"
			if [ $? -eq 0 ]; then echo "The connection has been established"
            else 
                echo "Something went wrong during the connection process"
            fi
	;;

		close)
			PID=$(lsof -i:1080 | grep ssh | awk {'print $2'} | uniq )
			if [ -d /proc/$PID/cwd ]; then kill -9 $PID && echo -e "Connection has been terminated successfully"
			else echo "Something went wrong! Please check manually."
	fi
	;;
		status)
			PID=$(lsof -i:1080 | grep ssh | awk {'print $2'} | uniq )
			if [ -d /proc/$PID/cwd ]; then echo -e "Socks proxy should be running on port 1080 with PID '$PID'"
			else echo "Seems that Socks proxy is not running"
	fi
	;;
	*)
			echo "Possible options are: connect + [ly|la] | close | status"
		esac

