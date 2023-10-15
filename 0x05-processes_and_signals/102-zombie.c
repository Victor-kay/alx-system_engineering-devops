#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

void createZombieProcesses() {
    pid_t child_pid;
    int i;

    for (i = 0; i < 5; i++) {
        child_pid = fork();
        if (child_pid < 0) {
            perror("Fork error");
            exit(1);
        } else if (child_pid == 0) {
            // This is the child process
            sleep(2); // Sleep to become a zombie
            exit(0);
        } else {
            // This is the parent process
            printf("Zombie process created, PID: %d\n", child_pid);
        }
    }

    // Parent process waits for all children to exit
    for (i = 0; i < 5; i++) {
        wait(NULL);
    }
}

int main() {
    createZombieProcesses();
    return 0;
}
