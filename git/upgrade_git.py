#!/usr/bin/env python
"""
Upgrade the git repos in current dir to latest. Error repos log into error.log.
2016-01-24, whatot
"""

import os
import queue
import threading
import logging
import subprocess


G_QUEUE = queue.Queue()
G_WORKER_THREAD_NUM = 8
G_ROOTPATH = os.getcwd()
GIT_UPGRADE_CMD = "git pull && git submodule update --init --recursive"
HG_UPGRADE_CMD = "hg pull && hg update"


class WorkerThread(threading.Thread):
    """main work thread process"""
    def __init__(self, t_name, t_queue):
        threading.Thread.__init__(self, name=t_name)
        self.queue = t_queue

    def run(self):
        while True:
            item = self.queue.get()
            run_cmd = "cd " + item[0] + " && " + item[1]
            print_header = ">>> update" + item[0] + "\n"
            try:
                out = subprocess.check_output(run_cmd, shell=True)
                print(print_header + out.decode())
            except subprocess.CalledProcessError as errorexception:
                print(print_header + errorexception.output.decode())
                logging.error(item[0])

            self.queue.task_done()

            if self.queue.empty():
                break


def put_task():
    """put all the repos in current dir into global task Queue: G_QUEUE."""
    for path in os.listdir(G_ROOTPATH):
        fullpath = os.path.join(G_ROOTPATH, path)
        if os.path.isdir(fullpath):
            if os.path.isdir(os.path.join(fullpath, '.git')):
                G_QUEUE.put([fullpath, GIT_UPGRADE_CMD])
            elif os.path.isdir(os.path.join(fullpath, '.hg')):
                G_QUEUE.put([fullpath, HG_UPGRADE_CMD])


def main():
    """error into error.log, start threads"""
    logformat = '%(asctime)s - %(levelname)s - %(name)s - %(message)s'
    logging.basicConfig(filename='error.log',
                        level=logging.ERROR,
                        format=logformat)
    threads = []
    put_task()

    for i in range(G_WORKER_THREAD_NUM):
        thread = WorkerThread("WorkerThread" + str(i), G_QUEUE)
        thread.start()
        threads.append(thread)
    for thread in threads:
        thread.join()

    G_QUEUE.join()
    print("All finished!")


if __name__ == '__main__':
    main()
