using Revise
using HPD 

path = joinpath(dirname(pathof(HPD)), "..", "test", "parser")
domain = load_domain(joinpath(path, "domain.pddl"))
problem = load_problem(joinpath(path, "problem.pddl"))