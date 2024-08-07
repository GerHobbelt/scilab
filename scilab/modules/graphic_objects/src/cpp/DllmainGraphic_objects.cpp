/*
 * Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2010 - DIGITEO - Allan CORNET
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

#include "DataModel.hxx"
#include "Plot3DDecomposer.hxx"
#ifdef _MSC_VER
#include <windows.h>
/*--------------------------------------------------------------------------*/
//for Visual Leak Detector in debug compilation mode
//#define DEBUG_VLD
#if defined(DEBUG_VLD) && defined(_DEBUG)
#include <vld.h>
#endif

extern "C"
{
    int WINAPI DllMain(HINSTANCE hInstance, DWORD reason, PVOID pvReserved);
}
/*--------------------------------------------------------------------------*/
//#pragma comment(lib,"../../../../bin/libintl.lib")
/*--------------------------------------------------------------------------*/
int WINAPI DllMain (HINSTANCE hInstance , DWORD reason, PVOID pvReserved)
{
    switch (reason)
    {
        case DLL_PROCESS_ATTACH:
            break;
        case DLL_PROCESS_DETACH:
            DataModel::destroy();
            Plot3DDecomposer::destroy();
            break;
        case DLL_THREAD_ATTACH:
            break;
        case DLL_THREAD_DETACH:
            break;
    }
    return 1;
}
#else
__attribute__((constructor)) static void load(void);
__attribute__((destructor)) static void unload(void);

void load(void)
{
}

void unload(void)
{
    DataModel::destroy();
    Plot3DDecomposer::destroy();
}
#endif
/*--------------------------------------------------------------------------*/

