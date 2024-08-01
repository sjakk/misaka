package ffi

import "core:c"




foreign import ffi "system:c"

tcflag_t :: uint
cc_t :: c.uchar
NCCS :: 32

TCSANOW : c.int : 0
CSIZE   : tcflag_t : 0o000000000060
CS5     : tcflag_t : 0o000000000000
CS6     : tcflag_t : 0o000000000020
CS7     : tcflag_t : 0o000000000040
CS8     : tcflag_t : 0o000000000060


termios :: struct{
	c_iflag: tcflag_t,
	c_oflag: tcflag_t,
	c_cflag: tcflag_t,
	c_lflag: tcflag_t,
	c_cc: [NCCS]cc_t,

}


@(default_calling_convention="c")
foreign ffi{

tcgetattr :: proc(fd: c.int,termptr: ^termios) -> c.int ---
tcsetattr :: proc(fd:c.int,opt:c.int,termptr: ^termios) -> c.int ---


}




//int tcsetattr(int fd, int opt, const struct termios *termptr);
//int tcgetattr(int fd, struct termios *termptr);
