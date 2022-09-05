# print ram usage in percent

echo "$(printf "%.0f" $(free | grep Mem | awk '{print $3/$2 * 100}'))"