"""Forensic.py: Determine which of the jobs in a job array failed to execute"""
import argparse
import subprocess
import string
import re

# PARSE ARGS ###################################################################
parser = argparse.ArgumentParser(
        description = "Determine which of the subprocessses failed"
        )
parser.add_argument(
        "job_id",
        nargs = "+",
        help = "SGE job ID of the job array to investigate"
        )
args = vars(parser.parse_args())

for job_id in args["job_id"]:
    # GET JOB INFO #############################################################
    qacct_output = subprocess.check_output(["qacct", "-j", job_id])
    qacct_output = str(qacct_output)
    lines = qacct_output.split("\\n")

    # PARSE QACCT OUTPUT #######################################################
    task_id = ""
    job_name = ""
    job_num_re = re.compile(r"taskid\s+(\d+)")
    job_name_re = re.compile(r"jobname\s+(\w+)")
    #jobname      H1ESC-100bp
    abnormal_exit_re = re.compile(r"exit_status\s+([1-9]\d*)")
    for line in lines:
        job_num_check = job_num_re.match(line)
        if job_num_check is not None:
            task_id = job_num_check.group(1)
        job_name_check = job_name_re.match(line)
        if job_name_check is not None:
            job_name = job_name_check.group(1)
        abnormal_exit_check = abnormal_exit_re.match(line)
        if abnormal_exit_check is not None:
            print("{0} {1}.{2}:{3}".format(job_name, job_id, task_id, line))
