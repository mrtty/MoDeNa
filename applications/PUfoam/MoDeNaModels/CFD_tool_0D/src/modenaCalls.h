/** @file modenaCalls.h
    @brief instantiates the surrogate models
*/
#ifndef MODENACALLS_H
#define MODENACALLS_H
/*
instantiate the surrogate models:
    - bubbleGrowth1,
    - bubbleGrowth2,
    - density_reaction_mixture,
    - rheology,
    - simpleKinetics
*/

bblgr1 = modena_model_new("bubbleGrowth1");
if (modena_error_occurred())
{
    return modena_error();
}

bblgr2 = modena_model_new("bubbleGrowth2");
if (modena_error_occurred())
{
    return modena_error();
}

kinetics = modena_model_new("RF-1-public");
if (modena_error_occurred())
{
    return modena_error();
}

density_reaction_mixturemodel = modena_model_new("density_reaction_mixture");
if (modena_error_occurred())
{
    return modena_error();
}

inputs_bblgr1 = modena_inputs_new(bblgr1);
outputs_bblgr1 = modena_outputs_new(bblgr1);

inputs_bblgr2 = modena_inputs_new(bblgr2);
outputs_bblgr2 = modena_outputs_new(bblgr2);

inputs_kinetics = modena_inputs_new(kinetics);
outputs_kinetics = modena_outputs_new(kinetics);

inputs_den = modena_inputs_new (density_reaction_mixturemodel);
outputs_den = modena_outputs_new (density_reaction_mixturemodel);


// inputs argPos
Catalyst_1_Pos   = modena_model_inputs_argPos(kinetics, "'Catalyst_1'");
CE_A0_Pos        = modena_model_inputs_argPos(kinetics, "'CE_A0'");
CE_A1_Pos        = modena_model_inputs_argPos(kinetics, "'CE_A1'");
CE_B_Pos         = modena_model_inputs_argPos(kinetics, "'CE_B'");
CE_B2_Pos        = modena_model_inputs_argPos(kinetics, "'CE_B2'");
CE_I0_Pos        = modena_model_inputs_argPos(kinetics, "'CE_I0'");
CE_I1_Pos        = modena_model_inputs_argPos(kinetics, "'CE_I1'");
CE_I2_Pos        = modena_model_inputs_argPos(kinetics, "'CE_I2'");
CE_PBA_Pos       = modena_model_inputs_argPos(kinetics, "'CE_PBA'");
CE_Breac_Pos     = modena_model_inputs_argPos(kinetics, "'CE_Breac'");
CE_Areac0_Pos    = modena_model_inputs_argPos(kinetics, "'CE_Areac0'");
CE_Areac1_Pos    = modena_model_inputs_argPos(kinetics, "'CE_Areac1'");
CE_Ireac0_Pos    = modena_model_inputs_argPos(kinetics, "'CE_Ireac0'");
CE_Ireac1_Pos    = modena_model_inputs_argPos(kinetics, "'CE_Ireac1'");
CE_Ireac2_Pos    = modena_model_inputs_argPos(kinetics, "'CE_Ireac2'");
Bulk_Pos         = modena_model_inputs_argPos(kinetics, "'Bulk'");
R_1_Pos          = modena_model_inputs_argPos(kinetics, "'R_1'");
R_1_mass_Pos     = modena_model_inputs_argPos(kinetics, "'R_1_mass'");
R_1_temp_Pos     = modena_model_inputs_argPos(kinetics, "'R_1_temp'");
R_1_vol_Pos      = modena_model_inputs_argPos(kinetics, "'R_1_vol'");

// First 20 outputs (source terms)
source_Catalyst_1_Pos   = modena_model_outputs_argPos(kinetics, "source_Catalyst_1");
source_CE_A0_Pos        = modena_model_outputs_argPos(kinetics, "source_CE_A0");
source_CE_A1_Pos        = modena_model_outputs_argPos(kinetics, "source_CE_A1");
source_CE_B_Pos         = modena_model_outputs_argPos(kinetics, "source_CE_B");
source_CE_B2_Pos        = modena_model_outputs_argPos(kinetics, "source_CE_B2");
source_CE_I0_Pos        = modena_model_outputs_argPos(kinetics, "source_CE_I0");
source_CE_I1_Pos        = modena_model_outputs_argPos(kinetics, "source_CE_I1");
source_CE_I2_Pos        = modena_model_outputs_argPos(kinetics, "source_CE_I2");
source_CE_PBA_Pos       = modena_model_outputs_argPos(kinetics, "source_CE_PBA");
source_CE_Breac_Pos     = modena_model_outputs_argPos(kinetics, "source_CE_Breac");
source_CE_Areac0_Pos    = modena_model_outputs_argPos(kinetics, "source_CE_Areac0");
source_CE_Areac1_Pos    = modena_model_outputs_argPos(kinetics, "source_CE_Areac1");
source_CE_Ireac0_Pos    = modena_model_outputs_argPos(kinetics, "source_CE_Ireac0");
source_CE_Ireac1_Pos    = modena_model_outputs_argPos(kinetics, "source_CE_Ireac1");
source_CE_Ireac2_Pos    = modena_model_outputs_argPos(kinetics, "source_CE_Ireac2");
source_Bulk_Pos         = modena_model_outputs_argPos(kinetics, "source_Bulk");
source_R_1_Pos          = modena_model_outputs_argPos(kinetics, "source_R_1");
source_R_1_mass_Pos     = modena_model_outputs_argPos(kinetics, "source_R_1_mass");
source_R_1_temp_Pos     = modena_model_outputs_argPos(kinetics, "source_R_1_temp");
source_R_1_vol_Pos      = modena_model_outputs_argPos(kinetics, "source_R_1_vol");

modena_model_argPos_check(kinetics);


#endif
