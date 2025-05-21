// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - Dassault Systèmes S.E. - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
//<-- CLI SHELL MODE -->
//<-- NO CHECK REF -->
//
// Load the reference SSP file from https://www.easy-ssp.com/app/
// Check various properties, sub-systems names and ports
//

function assert_check(scs_m)
    assert_checkequal(scs_m.props.title(1), "DC-Motor")
    assert_checkequal(length(scs_m.objs), 14);

    printf("checking scs_m.objs(1)\n")
    assert_checkequal(scs_m.objs(1).gui, "SSPOutputConnector")
    assert_checkequal(scs_m.objs(1).graphics.exprs(1), "M_mot")

    printf("checking scs_m.objs(2)\n")
    assert_checkequal(scs_m.objs(2).gui, "SSPOutputConnector")
    assert_checkequal(scs_m.objs(2).graphics.exprs(1), "wB")

    printf("checking scs_m.objs(3)\n")
    assert_checkequal(scs_m.objs(3).gui, "SSPOutputConnector")
    assert_checkequal(scs_m.objs(3).graphics.exprs(1), "U")

    printf("checking scs_m.objs(4)\n")
    assert_checkequal(scs_m.objs(4).gui, "SSPOutputConnector")
    assert_checkequal(scs_m.objs(4).graphics.exprs(1), "I")

    printf("checking scs_m.objs(5)\n")
    assert_checkequal(scs_m.objs(5).gui, "SSPOutputConnector")
    assert_checkequal(scs_m.objs(5).graphics.exprs(1), "M_load")

    printf("checking scs_m.objs(6)\n")
    assert_checkequal(scs_m.objs(6).gui, "SUPER_f")
    assert_checkequal(scs_m.objs(6).graphics.in_label, ["U";"M_load"])
    assert_checkequal(scs_m.objs(6).graphics.out_label, ["wB";"phiB";"M_mot";"I"])

    printf("checking scs_m.objs(7)\n")
    assert_checkequal(scs_m.objs(7).gui, "SimpleFMU")
    assert_checkequal(scs_m.objs(7).graphics.exprs, ["stimuli_model.fmu";"TMPDIR/resources/stimuli_model";"me 2.0"])
    assert_checkequal(scs_m.objs(7).graphics.out_label, ["U";"M_load"])

    //
    // Checking the sub-system
    //

    inner = scs_m.objs(6).model.rpar;
    assert_checkequal(inner.props.title(1), "SuT")
    assert_checkequal(length(inner.objs), 17);

    printf("checking scs_m.objs(6).model.rpar.objs(1)\n")
    assert_checkequal(inner.objs(1).gui, "OUT_f")
    assert_checkequal(inner.objs(1).graphics.exprs, "1")
    assert_checkequal(inner.objs(1).model.label, "wB")

    printf("checking scs_m.objs(6).model.rpar.objs(2)\n")
    assert_checkequal(inner.objs(2).gui, "IN_f")
    assert_checkequal(inner.objs(2).graphics.exprs, "2")
    assert_checkequal(inner.objs(2).model.label, "M_load")

    printf("checking scs_m.objs(6).model.rpar.objs(3)\n")
    assert_checkequal(inner.objs(3).gui, "OUT_f")
    assert_checkequal(inner.objs(3).graphics.exprs, "2")
    assert_checkequal(inner.objs(3).model.label, "phiB")

    printf("checking scs_m.objs(6).model.rpar.objs(4)\n")
    assert_checkequal(inner.objs(4).gui, "IN_f")
    assert_checkequal(inner.objs(4).graphics.exprs, "1")
    assert_checkequal(inner.objs(4).model.label, "U")

    printf("checking scs_m.objs(6).model.rpar.objs(5)\n")
    assert_checkequal(inner.objs(5).gui, "OUT_f")
    assert_checkequal(inner.objs(5).graphics.exprs, "3")
    assert_checkequal(inner.objs(5).model.label, "M_mot")

    printf("checking scs_m.objs(6).model.rpar.objs(6)\n")
    assert_checkequal(inner.objs(6).gui, "OUT_f")
    assert_checkequal(inner.objs(6).graphics.exprs, "4")
    assert_checkequal(inner.objs(6).model.label, "I")

    printf("checking scs_m.objs(6).model.rpar.objs(7)\n")
    assert_checkequal(inner.objs(7).gui, "SimpleFMU")
    assert_checkequal(inner.objs(7).graphics.exprs, ["edrive_mass.fmu";"TMPDIR/resources/edrive_mass";"me 2.0"])
    assert_checkequal(inner.objs(7).graphics.in_label, ["M_A";"M_B"])
    assert_checkequal(inner.objs(7).graphics.out_label, ["wA";"phiA";"wB";"phiB"])

    printf("checking scs_m.objs(6).model.rpar.objs(8)\n")
    assert_checkequal(inner.objs(8).gui, "SimpleFMU")
    assert_checkequal(inner.objs(8).graphics.exprs, ["emachine_model.fmu";"TMPDIR/resources/emachine_model";"me 2.0"])
    assert_checkequal(inner.objs(8).graphics.in_label, ["w";"phi";"U"])
    assert_checkequal(inner.objs(8).graphics.out_label, ["M";"I"])
endfunction

scs_m = scicosDiagramToScilab("SCI/modules/xcos/tests/unit_tests/DC Motor.ssp");
assert_check(scs_m);

// save and load back
scicosDiagramToScilab("TMPDIR/DC Motor.ssp", scs_m);
scs_m_reloaded = scicosDiagramToScilab("TMPDIR/DC Motor.ssp");
assert_check(scs_m_reloaded);
