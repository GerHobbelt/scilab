/*
*  Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
*  Copyright (C) 2009-2009 - DIGITEO - Bruno JOFRET
*
*  This file must be used under the terms of the CeCILL.
*  This source file is licensed as described in the file COPYING, which
*  you should have received as part of this distribution.  The terms
*  are also available at
*  http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
*
*/

#include "tasks.hxx"
#include "timer.hxx"
#include "context.hxx"
#include "visitor.hxx"
#include "printvisitor.hxx"
#include "execvisitor.hxx"
#include "timedvisitor.hxx"
#include "debugvisitor.hxx"
#include "stepvisitor.hxx"
#include "AnalysisVisitor.hxx"
#include "visitor_common.hxx"

#include "scilabWrite.hxx"
#include "runner.hxx"

#define SCILAB_START    L"/etc/scilab.start"
#define SCILAB_QUIT     L"/etc/scilab.quit"

Timer _timer;

//#define DEBUG

/*
** Parse
**
** Parse the given file and create the AST.
*/
void parseFileTask(Parser *parser, bool timed, const wchar_t* file_name, const wchar_t* prog_name)
{
#ifdef DEBUG
    std::cerr << "*** Processing " << file_name << " file..." << std::endl;
#endif

    if (timed)
    {
        _timer.start();
    }

    parser->parseFile(file_name, prog_name);

    if (timed)
    {
        _timer.check(L"Parsing");
    }
}

/*
** Parse
**
** Parse the given command and create the AST.
*/
void parseCommandTask(Parser *parser, bool timed, char *command)
{
#ifdef DEBUG
    std::cerr << "*** Processing [" <<  command << "]..." << std::endl;
#endif

    if (timed)
    {
        _timer.start();
    }

    parser->parse(command);

    if (timed && parser->getControlStatus() == Parser::AllControlClosed)
    {
        _timer.check(L"Parsing");
    }
}

/*
** Dump AST
**
** Display the AST in human readable format.
*/
void dumpAstTask(ast::Exp *tree, bool timed)
{
    if (timed)
    {
        _timer.start();
    }

    ast::DebugVisitor debugMe;
    if (tree)
    {
        tree->accept(debugMe);
    }

    if (timed)
    {
        _timer.check(L"AST Dump");
    }
}

/*
** Pretty Print
**
** Pretty print the Stored AST.
*/
void printAstTask(ast::Exp *tree, bool timed)
{
    if (timed)
    {
        _timer.start();
    }

    if (tree)
    {
        ast::PrintVisitor printMe = *new ast::PrintVisitor(std::wcout);
        tree->accept(printMe);
    }

    if (timed)
    {
        _timer.check(L"Pretty Print");
    }
}


/*
** Exec Tree
**
** Execute the stored AST.
*/
void execAstTask(ast::Exp* tree, bool serialize, bool timed, bool ASTtimed, bool execVerbose, bool isPriorityThread)
{
    if (tree == NULL)
    {
        return;
    }

    ast::Exp* newTree = NULL;
    if (serialize)
    {
        if (timed)
        {
            newTree = callTyper(tree, L"tasks");
        }
        else
        {
            newTree = callTyper(tree);
        }

        delete tree;
    }
    else
    {
        newTree = tree;
    }

    ast::ExecVisitor *exec;
    if (timed)
    {
        _timer.start();
    }

    if (ASTtimed)
    {
        exec = (ast::ExecVisitor*)new ast::TimedVisitor();
    }

    if (execVerbose)
    {
        exec = (ast::ExecVisitor*)new ast::StepVisitor();
    }

    if (!execVerbose && !ASTtimed)
    {
        //call analyzer visitor before exec visitor
        if (ConfigVariable::getAnalyzerOptions() == 1)
        {
            analysis::AnalysisVisitor analysis;
            newTree->accept(analysis);
        }

        exec = new ast::ExecVisitor();
    }

    Runner::execAndWait(newTree, exec, isPriorityThread);
    //DO NOT DELETE tree or newTree, they was deleted by Runner or previously;

    if (timed)
    {
        _timer.check(L"Execute AST");
    }
}

/*
** Dump Stack Trace
**
** Display what is stored in scilab.
*/
void dumpStackTask(bool timed)
{
    if (timed)
    {
        _timer.start();
    }

    symbol::Context::getInstance()->print(std::wcout);

    if (timed)
    {
        _timer.check(L"Dumping Stack");
    }
}

/*
** Execute scilab.start
**
*/
void execScilabStartTask(bool _bSerialize)
{
    Parser parse;
    wstring stSCI = ConfigVariable::getSCIPath();

    stSCI += SCILAB_START;
    parse.parseFile(stSCI, L"");

    if (parse.getExitStatus() != Parser::Succeded)
    {
        scilabWriteW(parse.getErrorMessage());
        scilabWriteW(L"Failed to parse scilab.start");
        return;
    }

    execAstTask(parse.getTree(), _bSerialize, false, false, false, true);
}

/*
** Execute scilab.quit
**
*/
void execScilabQuitTask(bool _bSerialize)
{
    Parser parse;
    wstring stSCI = ConfigVariable::getSCIPath();

    stSCI += SCILAB_QUIT;
    parse.parseFile(stSCI, L"");

    if (parse.getExitStatus() != Parser::Succeded)
    {
        scilabWriteW(parse.getErrorMessage());
        scilabWriteW(L"Failed to parse scilab.quit");
        return;
    }

    execAstTask(parse.getTree(), _bSerialize, false, false, false, true);
}

