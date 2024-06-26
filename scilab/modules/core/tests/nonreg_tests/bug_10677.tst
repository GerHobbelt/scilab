// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - Scilab Enterprises - Cedric Delamarre
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 10677 -->
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/10677
//
// <-- Short Description -->
// %to_6=%to_e crashs scilab on Windows 64 version (release)

function M=%to_e(varargin)
  M = varargin($),
  select varargin(1)
    case 'row2' then
    M.N = M.N(2, eye())
    M.V = M.V(2, eye())
  case 'row1' then
    M.N = M.N(1, eye())
    M.V = M.V(1, eye())
  else
    M.N = M.N(varargin(1:$ - 1))
    M.V = M.V(varargin(1:$ - 1))
  end
endfunction

%to_6=%to_e;
