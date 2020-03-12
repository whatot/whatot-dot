#!/usr/bin/env python
"""
Upgrade the git repos in current dir to latest. Error repos log into error.log.
2016-01-24, init
2020-03-12, retry
"""

import os
import queue
import threading
import logging
import subprocess

WORK_THREAD_NUM = 4
MAX_RETRY_COUNT = 3
GIT_UPGRADE_CMD = "git pull && git submodule update --init --recursive && git gc"
HG_UPGRADE_CMD = "hg pull && hg update"

logging.basicConfig(
    filename="error.log",
    level=logging.ERROR,
    format="%(asctime)s - %(levelname)s - %(name)s - %(message)s",
)


class WorkerThread(threading.Thread):
    """main work thread process"""

    def __init__(self, t_name, t_queue):
        threading.Thread.__init__(self, name=t_name)
        self.queue = t_queue

    def run(self):
        while True:
            item = self.queue.get()
            path = item[0]
            cmd = item[1]
            retry_count = item[2]
            run_cmd = "cd " + path + " && " + cmd
            print_header = ">>> update " + path + "\n"

            if retry_count > MAX_RETRY_COUNT:
                logging.error("%s end retry: %d", path, retry_count)
                continue

            try:
                out = subprocess.check_output(run_cmd, shell=True)
                print(print_header + out.decode())
            except subprocess.CalledProcessError as errorexception:
                print(print_header + errorexception.output.decode())
                logging.error("%s failed retry: %d", path, retry_count)
                self.queue.put([path, cmd, retry_count + 1])

            self.queue.task_done()

            if self.queue.empty():
                break


def put_task(root_path, work_queue):
    """put all the repos in current dir into global task Queue: G_QUEUE."""
    for path in os.listdir(root_path):
        fullpath = os.path.join(root_path, path)
        if os.path.isdir(fullpath):
            if os.path.isdir(os.path.join(fullpath, ".git")):
                work_queue.put([fullpath, GIT_UPGRADE_CMD, 0])
            elif os.path.isdir(os.path.join(fullpath, ".hg")):
                work_queue.put([fullpath, HG_UPGRADE_CMD, 0])


def main():
    """init queue, then start threads"""
    root_path = os.getcwd()
    work_queue = queue.Queue()
    threads = []
    put_task(root_path, work_queue)

    for i in range(WORK_THREAD_NUM):
        thread = WorkerThread("WorkerThread" + str(i), work_queue)
        thread.start()
        threads.append(thread)
    for thread in threads:
        thread.join()

    work_queue.join()
    print("All finished!")


if __name__ == "__main__":
    main()
