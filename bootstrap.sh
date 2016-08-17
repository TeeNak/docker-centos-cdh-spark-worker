#!/bin/bash


# When using service command it says "Failed to get D-Bus connection: Operation not permitted"
# There is 3 ways to work around this phenomenon.
# 1. Use /sbin/init and let the service start from it.
# 2. Run docker with --privileged option.
# 3. Avoid using service command and just use the daemon script directly
# And my choice is 3. because the feature provided in service command is not actually needed at this morment.

/etc/rc3.d/S85hadoop-hdfs-datanode start

if [ $? -gt 0 ]; then
    echo "Starting daemon failed."
    exit 1
fi

/etc/rc3.d/S85hadoop-yarn-nodemanager start

if [ $? -gt 0 ]; then
    echo "Starting daemon failed."
    exit 1
fi



CMD=${1:-"exit 0"}
if [[ "$CMD" == "-d" ]];
then
	#service sshd stop
	#/usr/sbin/sshd -D -d
        
        #Temporary doing this way at this moment, the thing we need actually is supervisord
        /bin/bash -c "while true; do sleep 1; done"
else
	echo "$*"
	/bin/bash -c "$*"
fi
