// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2025 - Dassault Systèmes S.E. - Cédric DELAMARRE
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- NO CHECK ERROR OUTPUT -->
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->

// check a command
status = host("echo OK");
assert_checktrue(status == 0);

// check a non existing command
status = host("wrong_command");
assert_checktrue(status <> 0);

// check stdout
[status, stdout] = host("echo OK");
assert_checktrue(status == 0);
assert_checkequal(stripblanks(stdout), "OK");

// check a command outputting to both stdout and stderr
[status, stdout, stderr] = host("echo OK && wrong_command");
assert_checkequal(stripblanks(stdout), "OK");
assert_checkfalse(status == 0);
assert_checkfalse(stderr == "");
