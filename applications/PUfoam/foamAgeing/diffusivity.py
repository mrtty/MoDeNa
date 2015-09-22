'''

   ooo        ooooo           oooooooooo.             ooooo      ooo
   `88.       .888'           `888'   `Y8b            `888b.     `8'
    888b     d'888   .ooooo.   888      888  .ooooo.   8 `88b.    8   .oooo.
    8 Y88. .P  888  d88' `88b  888      888 d88' `88b  8   `88b.  8  `P  )88b
    8  `888'   888  888   888  888      888 888ooo888  8     `88b.8   .oP"888
    8    Y     888  888   888  888     d88' 888    .o  8       `888  d8(  888
   o8o        o888o `Y8bod8P' o888bood8P'   `Y8bod8P' o8o        `8  `Y888""8o

Copyright
    2014-2015 MoDeNa Consortium, All rights reserved.

License
    This file is part of Modena.

    Modena is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License as published by the Free
    Software Foundation, either version 3 of the License, or (at your option)
    any later version.

    Modena is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License along
    with Modena.  If not, see <http://www.gnu.org/licenses/>.

Description
    Python library of FireTasks

Authors
    Henrik Rusche

Contributors
'''

import os
import modena
from modena import CFunction, IndexSet, Workflow2, \
    ForwardMappingModel, BackwardMappingModel, SurrogateModel
import modena.Strategy as Strategy
from fireworks.user_objects.firetasks.script_task import FireTaskBase, ScriptTask
from fireworks import Firework, Workflow, FWAction
from fireworks.utilities.fw_utilities import explicit_serialize
from blessings import Terminal
from jinja2 import Template

# Create terminal for colour output
term = Terminal()


__author__ = 'Henrik Rusche'
__copyright__ = 'Copyright 2014, MoDeNa Project'
__version__ = '0.2'
__maintainer__ = 'Henrik Rusche'
__email__ = 'h.rusche@wikki.co.uk.'
__date__ = 'Sep 4, 2014'

species = IndexSet(
    _id= 'diffusivity_pol_species',
    names= [ 'CO2', 'CyP', 'N2', 'O2' ]
)

f_diffusivity = CFunction(
    Ccode='''
#include "modena.h"
#include "math.h"

void diffusivityPol
(
    const double* parameters,
    const double* inherited_inputs,
    const double* inputs,
    double *outputs
)
{
    const double T = inputs[0];

    const double a = parameters[0];
    const double b = parameters[1];

    outputs[0] = a*exp(-(b*(1/T)));
}
''',
    # These are global bounds for the function
    inputs={
        'T': {'min': 273, 'max': 450, 'argPos': 0},
    },
    outputs={
        'diffusivity': {'min': 0, 'max': +9e99, 'argPos': 0},
    },
    parameters={
        'param0[A]': {'min': 0.0, 'max': +9e99, 'argPos': 0},
        'param1[A]': {'min': 0.0, 'max': +9e99, 'argPos': 1},
    },
    indices={
        'A': species,
    },
)
m_CO2_diffusivity = ForwardMappingModel(
    _id='diffusivityPol[A=CO2]',
    surrogateFunction=f_diffusivity,
    substituteModels=[],
    parameters=[0.00123, 6156],
)
m_CyP_diffusivity = ForwardMappingModel(
    _id='diffusivityPol[A=CyP]',
    surrogateFunction=f_diffusivity,
    substituteModels=[],
    parameters=[1.7e-7, 4236],
)
m_N2_diffusivity = ForwardMappingModel(
    _id='diffusivityPol[A=N2]',
    surrogateFunction=f_diffusivity,
    substituteModels=[],
    parameters=[0.003235, 6927],
)
m_O2_diffusivity = ForwardMappingModel(
    _id='diffusivityPol[A=O2]',
    surrogateFunction=f_diffusivity,
    substituteModels=[],
    parameters=[0.00085, 6411],
)
