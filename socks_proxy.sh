
#!/bin/bash
source ../proxy_servers
read -p "Enter login:" login
read -p "Enter destination: (ly or la)" destination
	case $destination in 
	LA | La | la | lA)
			echo "calling to Mephistopheles of Los Angeles..."
        		ssh -f -C2qTnN -D 1080 $login@$laserver -p2212 && echo -e  " '$?'  - is the result of calling server"
			echo "checking with netstat...:"
			sudo netstat -tulpn | grep 1080
	;;
	LY | Ly | ly | lY)
			echo "calling Lithuania server..."
			ssh -f -C2qTnN -D 1080 $login@$lyserver -p2212 && echo -e " '$?' - is the result of calling server"
			echo "calling netstat...:"
			sudo netstat -tulpn | grep 1080
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
			echo "Possible options are: close | check"
		esac

