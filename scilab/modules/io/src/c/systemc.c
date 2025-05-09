/*
* Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
* Copyright (C) 2010 - DIGITEO - Allan CORNET
 * Copyright (C) 2012 - 2016 - Scilab Enterprises
 *
 * This file is hereby licensed under the terms of the GNU GPL v2.0,
 * pursuant to article 5.3.4 of the CeCILL v.2.1.
 * This file was originally licensed under the terms of the CeCILL v2.1,
 * and continues to be available under such terms.
 * For more information, see the COPYING file which you should have received
 * along with this program.
*
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include "sci_malloc.h"
#include "Thread_Wrapper.h"
#include "os_string.h"
#include "charEncoding.h"
#include "systemc.h"
#include "scilabWrite.hxx"

#define LF_STR '\n'
typedef struct pipeinfo
{
    int pipe;
    char* buffer;
} pipeinfo;

static pipeinfo piOut = {0, NULL};
static pipeinfo piErr = {0, NULL};

static void* readOutput(void* data)
{
    pipeinfo* pi = (pipeinfo*)data;
    char buffer[2048];
    FILE* file = fdopen(pi->pipe, "r");
    if (file == NULL)
    {
        return NULL;
    }

    size_t msg_size = 4096;
    char* msg = (char*)MALLOC(msg_size);
    memset(msg, 0, msg_size);
    size_t current_size = 0;
    while (fgets(buffer, sizeof(buffer), file) != NULL)
    {
        current_size += strlen(buffer);
        if(current_size > msg_size)
        {
            msg_size += 2048;
            msg = (char*)realloc(msg, msg_size * sizeof(char));
        }
        strcat(msg, buffer);
    }

    pi->buffer = msg;
    fclose(file);
    return NULL;
}

int splitstring(char* output, char*** splited)
{
    int outlines = 0;
    char* pointer = output;
    while (pointer = strchr(pointer, LF_STR))
    {
        outlines++;
        pointer++;
    }

    *splited = (char**)malloc(outlines * sizeof(char*));
    memset(*splited, 0x00, sizeof(char*) * outlines);

    for(int i = 0; i < outlines; i++)
    {
        pointer = strchr(output, LF_STR);
        (*splited)[i] = output;
        if(pointer)
        {
            *pointer = '\0';
        }

        size_t len = strlen(output);
        output += len + 1;
    }

    return outlines;
}

int spawncommand(wchar_t* _pstCommand, BOOL bOutput, char** stdoutstr, char** stderrstr)
{
    int stdout_pipe[2] = {0};
    int stderr_pipe[2] = {0};
    pid_t pid;
    int status = 0;

    if (bOutput && (pipe(stdout_pipe) == -1 || pipe(stderr_pipe) == -1))
    {
        return -1;
    }

    pid = fork();
    if (pid == -1)
    {
        return -1;
    }

    char* cmd = wide_string_to_UTF8(_pstCommand);
    if (pid == 0)
    {
        // executed by the child process
        if(bOutput)
        {
            // close read end of stdout/stderr pipe
            close(stdout_pipe[0]);
            close(stderr_pipe[0]);

            // redirect to pipe
            dup2(stdout_pipe[1], STDOUT_FILENO);
            dup2(stderr_pipe[1], STDERR_FILENO);

            // close write end of stdout/stderr pipe
            close(stdout_pipe[1]);
            close(stderr_pipe[1]);
        }

        // execute the command
        execl("/bin/sh", "sh", "-c", cmd, (char *)NULL);

        // if this code runs it because the execution has failed
        // exit the child process
        exit(EXIT_FAILURE);
    }

    FREE(cmd);

    // executed by the parent process (pid is the child pid)
    if(bOutput)
    {
        // close write end of stdout/stderr pipe
        close(stdout_pipe[1]);
        close(stderr_pipe[1]);

        // if detach, do not get output ?
        // spawn threads for each output
        piOut.pipe = stdout_pipe[0];
        __threadId threadStdOut;
        __threadKey keyStdOut;
        __CreateThreadWithParams(&threadStdOut, &keyStdOut, &readOutput, &piOut);

        piErr.pipe = stderr_pipe[0];
        __threadId threadStdErr;
        __threadKey keyStdErr;
        __CreateThreadWithParams(&threadStdErr, &keyStdErr, &readOutput, &piErr);

        waitpid(pid, &status, 0);

        // in case of detached command, do not wait for outputs
        if(piOut.buffer || piErr.buffer)
        {
            __WaitThreadDie(threadStdOut);
            __WaitThreadDie(threadStdErr);
            *stdoutstr = piOut.buffer;
            *stderrstr = piErr.buffer;
        }
    }

    waitpid(pid, &status, 0);
    if (WIFEXITED(status))
    {
        return WEXITSTATUS(status);
    }

    // error if the child did not terminate normally
    return -1;
}
