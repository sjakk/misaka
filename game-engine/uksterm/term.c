#include <termios.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>

#define MAXLINE 4096

static void err_doit(int errnoflag, int error, const char *fmt, va_list ap)
{
char buf[MAXLINE];
vsnprintf(buf, MAXLINE-1, fmt, ap);
if (errnoflag)
snprintf(buf+strlen(buf), MAXLINE-strlen(buf)-1, ": %s",
strerror(error));
strcat(buf, "\n");
fflush(stdout); /* in case stdout and stderr are the same */
fputs(buf, stderr);
fflush(NULL); /* flushes all stdio output streams */
}



void err_sys(const char* x) 
{ 
    perror(x); 
    exit(1); 
}

void err_quit(const char *fmt, ...)
{
va_list ap;
va_start(ap, fmt);
err_doit(0, 0, fmt, ap);
va_end(ap);
exit(1);
}


int
main(void)
{
struct termios term;
if (tcgetattr(STDIN_FILENO, &term) < 0)
err_sys("tcgetattr error");
switch (term.c_cflag & CSIZE) {
case CS5:
printf("5 bits/byte\n");
break;
case CS6:
printf("6 bits/byte\n");
break;
case CS7:
printf("7 bits/byte\n");
break;
case CS8:
printf("8 bits/byte\n");
break;
default:
printf("unknown bits/byte\n");
}
term.c_cflag &= ~CSIZE; /* zero out the bits */
term.c_cflag |= CS8; /* set 8 bits/byte */
if (tcsetattr(STDIN_FILENO, TCSANOW, &term) < 0)
err_sys("tcsetattr error");
exit(0);
}
