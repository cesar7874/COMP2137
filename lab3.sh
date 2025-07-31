#!/bin/bash

# Set the base hostname number
student_id="200510185"
hostnum="${student_id: -2}"  # Get last two digits (85)

# List of containers to configure
containers=("server1" "server2")

for index in "${!containers[@]}"; do
    container="${containers[$index]}"
    # Add the index to the host number (85 + 0 = 85, 85 + 1 = 86)
    new_host="server$((10#$hostnum + index))"

    echo "→ Configuring $container with hostname $new_host"

    # Push script to container
    incus file push configure-host.sh "$container"/root/

    # Make it executable
    incus exec "$container" -- chmod +x /root/configure-host.sh

    # Run the script inside the container 
    incus exec "$container" -- /root/configure-host.sh -name "$new_host"
done
