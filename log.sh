# exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_log_file>"
    exit 1
fi

logfile=$1

# file exists and is readable
if [ ! -r "$logfile" ]; then
    echo "Error: Log file does not exist or is not readable"
    exit 1
fi


total_requests=$(wc -l < "$logfile")
echo "Total Requests Count: $total_requests"


successful_requests=$(grep -c '" [2][0-9][0-9] ' "$logfile")
percentage_successful=$(awk "BEGIN { printf \"%.2f\", ($successful_requests / $total_requests) * 100 }")
echo "Percentage of Successful Requests: $percentage_successful%"


most_active_user=$(awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
echo "Most Active User: $most_active_user"

exit 0
