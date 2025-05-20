/*
 *  Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
 *  Copyright (C) 2010-2010 - DIGITEO - Bruno JOFRET
 *
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


#include <string.h>
#include "io_gw.hxx"
#include "string.hxx"
#include "function.hxx"
#include "double.hxx"

extern "C"
{
#ifdef _MSC_VER
#include "spawncommand.h"
#else
#include "systemc.h"
#endif

#include "localization.h"
#include "Scierror.h"
}

types::Function::ReturnValue sci_host(types::typed_list &in, int _iRetCount, types::typed_list &out)
{
    if (in.size() < 1 || in.size() > 2)
    {
        Scierror(77, _("%s: Wrong number of input argument(s): %d to %d expected.\n"), "host", 1, 2);
        return types::Function::Error;
    }

    if (_iRetCount == 2 || _iRetCount > 3)
    {
        Scierror(78, _("%s: Wrong number of output argument(s): %d or %d expected.\n"), "host", 1, 3);
        return types::Function::Error;
    }

    types::InternalType* pIT = in[0];

    if (pIT->isString() == false || pIT->getAs<types::String>()->getSize() != 1)
    {
        Scierror(89, _("%s: Wrong size for input argument #%d: string expected.\n"), "host", 1);
        return types::Function::Error;
    }

    wchar_t* pstCommand = pIT->getAs<types::String>()->get(0);

    char** output = NULL;
    char** error = NULL;
    int outlines = 0;
    int errlines = 0;
#ifdef _MSC_VER
    double stat = (double)spawncommand(pstCommand, FALSE);
    if(_iRetCount > 1)
    {
        output = CreateOutput(&pipeSpawnOut, FALSE);
        outlines = pipeSpawnOut.NumberOfLines;
        if(_iRetCount == 3)
        {
            error = CreateOutput(&pipeSpawnErr, FALSE);
            errlines = pipeSpawnErr.NumberOfLines;
        }
    }
#else
    char* stdoutstr = nullptr;
    char* stderrstr = nullptr;
    BOOL bOutput = _iRetCount > 1 ? TRUE : FALSE;
    int stat = spawncommand(pstCommand, bOutput, &stdoutstr, &stderrstr);
    if(bOutput && stdoutstr && stderrstr)
    {
        outlines = splitstring(stdoutstr, &output);
        errlines = splitstring(stderrstr, &error);
    }
#endif

    out.push_back(new types::Double(stat));
    if (_iRetCount > 1)
    {
        types::String* pStr = nullptr;
        if (outlines && output[0] != NULL)
        {
            pStr = new types::String(outlines, 1);
            pStr->set(output);
            out.push_back(pStr);
        }
        else
        {
            out.push_back(new types::String(""));
        }

        if (errlines && error[0] != NULL)
        {
            pStr = new types::String(errlines, 1);
            pStr->set(error);
            out.push_back(pStr);
        }
        else
        {
            out.push_back(new types::String(""));
        }
    }

#ifdef _MSC_VER
    ClosePipeInfo(pipeSpawnOut);
    ClosePipeInfo(pipeSpawnErr);

    for(int i = 0; i < outlines; i++)
    {
        if (output[i])
        {
            FREE(output[i]);
        }
    }

    for(int i = 0; i < errlines; i++)
    {
        if (error[i])
        {
            FREE(error[i]);
        }
    }
#else
    FREE(stdoutstr);
    FREE(stderrstr);
    FREE(output);
    FREE(error);
#endif
    return types::Function::OK;
}
