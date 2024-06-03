
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

service_name=$1


if systemctl is-active --quiet "$service_name"; then
    echo "The service '$service_name' is running."
else
    echo "The service '$service_name' is not running."
fi

exit 0
