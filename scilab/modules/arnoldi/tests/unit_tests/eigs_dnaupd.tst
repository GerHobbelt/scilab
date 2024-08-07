// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - SE - Sylvestre Ledru
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->

nx    = 10;

nev   = 3;
ncv   = 6;
bmat  = 'I';
which = 'LM';

// Local Arrays

iparam  = zeros(11, 1);
ipntr   = zeros(14, 1);
_select = zeros(ncv, 1);
dr       = zeros(nev + 1, 1);
di      = zeros(nev + 1, 1);
z       = zeros(nx, nev + 1);
resid   = zeros(nx, 1);
v       = zeros(nx, ncv);
workd   = zeros(3 * nx, 1);
workev  = zeros(3 * ncv, 1);
workl   = zeros(3 * ncv * ncv + 6 * ncv, 1);

// Build the test matrix

A            = diag(10 * ones(nx, 1));
A(1:$-1,2:$) = A(1:$-1,2:$) + diag(6 * ones(nx-1,1));
A(2:$,1:$-1) = A(2:$,1:$-1) + diag(-6 * ones(nx-1,1));

tol    = 0;
ido    = 0;

ishfts = 1;
maxitr = 300;
mode1  = 1;

iparam(1) = ishfts;
iparam(3) = maxitr;
iparam(7) = mode1;

sigmar = 0; // the real part of the shift
sigmai = 0; // the imaginary part of the shift
info_dnaupd = 0;

// M A I N   L O O P (Reverse communication)

while(ido <> 99)
    // Repeatedly call the routine DNAUPD and take actions indicated by parameter IDO until
    // either convergence is indicated or maxitr has been exceeded.

    [ido, resid, v, iparam, ipntr, workd, workl, info_dnaupd] = %_dnaupd(ido, bmat, nx, which, nev, tol, resid, ncv, v, iparam, ipntr, workd, workl, info_dnaupd);

    if(info_dnaupd < 0)
        printf('\nError with dnaupd, info = %d\n',info_dnaupd);
        printf('Check the documentation of dnaupd\n\n');
    end

    if(ido == -1 | ido == 1)
        // Perform matrix vector multiplication
        workd(ipntr(2):ipntr(2) + nx -1) = A * workd(ipntr(1):ipntr(1) + nx - 1);
    end
end

// Post-Process using DNEUPD.
rvec    = 1;
howmany = 'A';
info_dneupd = 0;

[dr, di, z, resid, v, iparam, ipntr, workd, workl, info_dneupd] = %_dneupd(rvec, howmany, _select, dr, di, z, sigmar, sigmai, workev, ...
bmat, nx, which, nev, tol, resid, ncv, v, ...
iparam, ipntr, workd, workl, info_dneupd);

d = complex(dr, di);
d(nev+1) = [];
d = diag(d);

c1 = 1:2:nev + 1;
c2 = 2:2:nev + 1;
if(modulo(nev + 1, 2) == 1)
    c1($) = [];
end
z(:,[c1, c2]) = [z(:,c1) + z(:,c2) * %i z(:,c1) - z(:,c2) * %i];
z(:,$) = [];

assert_checkalmostequal(A * z, z * d, sqrt(%eps), 1.e-10);
