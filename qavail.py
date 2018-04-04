import os
import re
import sys

from tabulate import tabulate

qstat = os.popen("qstat -u '*' " + " ".join(sys.argv[1:]), "r")
lines_read = 0
users = {};
job_stats = {};
slots_position = 0

# Figure out where the user/queue is
user_start = 0
user_end = 0
queue_start = 0
queue_end = 0
for line in qstat:
    lines_read += 1
    if lines_read < 4:
        # Parse out the header to get the position of the number of slots consumed
        if lines_read == 1:
            user_start = line.find("user")
            user_end = line.find("state")
            queue_start = user_end
            queue_end = line.find("submit")
            slots_position = re.search(r'slots', line).span()[1]

        # ...and skip the rest of the header
        lines_read += 1
        continue

    re_out = re.search(r'(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+', line)
    if re_out is None:
        print(line)
    else:
        user = line[user_start:user_end]
        queue = line[queue_start:queue_end]
        if not queue in job_stats:
            job_stats[queue] = {}

        # Figure out number of jobs to count this line as
        slots = 0
        array_search = re.search(r'(\d+)-(\d+):\d\s+', line)
        if array_search:
            slots = int(array_search.group(2)) - int(array_search.group(1)) + 1
        else:
            slot_search = re.search(r'([0-9]+)\s*$', line[0:slots_position])
            if not slot_search:
                print(line)
            slots = int(slot_search.group(1))
        if user in job_stats[queue]:
            job_stats[queue][user] += slots
        else:
            job_stats[queue][user] = slots

# Sort each queue of users
num_rows = max([len(job_stats[queue]) for queue in job_stats])
final_list = [()] * num_rows
status_order = sorted(job_stats.keys(), reverse=True)
for status in status_order:
    queue = job_stats[status]
    sorted_users = sorted(queue.items(), key=lambda queue: queue[1], reverse=True)
    for i in range(len(sorted_users), num_rows):
        sorted_users.append(('', ''))
    final_list = [sum(zipped, ()) for zipped in zip(final_list, sorted_users)]

# Prepare table header and print
header = [('user', queue.strip()) for queue in status_order]
header = list(sum(header, ()))  # Flatten the list
print(tabulate(final_list, headers=header))
