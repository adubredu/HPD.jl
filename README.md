# HPD.jl 
## Parser for the Hybrid PDDL Description language.

HPD is an extension of PDDL to enable the specification of numerical constraints
of arbitrary forms (linear, quadratic, cubic, nonlinear, trigonometric, etc.) as 
well as the specification of continuous variables, continuous action preconditions,
continuous action effects, action dynamics functions, and arbitrary objective functions.

## Installation
1. Open your Julia REPL by typing  `julia` in your terminal.
2. Press `]` on your keyboard to enter the package manager
3. Enter command `add https://github.com/adubredu/HPD.jl` and press 
`Enter` on your keyboard to install this package.
4. Press the `Backspace` key on your keyboard to return to the REPL

## Usage 
Alongside the usual requirements of a PDDL 2.1 domain file, actions in an HPD domain file require fields `:continuous_precondition`, `:dynamics` and `continuous_effect`.

An HPD problem file requires fields `:continuous_inits`, `:continuous_goals`, `:external_constraints` and `:objective_function`.

See [examples](examples) for examples of `domain.hpd` and `problem.hpd` files.

Here's a usage example of the HPD parser:

```julia
using HPD 

# get path to .hpd file
path = joinpath(dirname(pathof(HPD)), "..", "examples") 

# loading domain file
domain = load_domain(joinpath(path, "domain.hpd"))

#loading problem file
problem = load_problem(joinpath(path, "problem.hpd"))

#Getting initial state as well as all initial continuous variable values
init = initstate(domain, problem)

#Getting goal state as well as all goal continuous variable values
goal = goalstate(domain, problem)

```

## Acknowledgement
This package extends and heavily relies on [ztangent's](https://github.com/ztangent/) awesome [PDDL.jl](https://github.com/JuliaPlanners/PDDL.jl) package.

