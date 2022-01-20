using Revise
using HPD 

path = joinpath(dirname(pathof(HPD)), "..", "test", "parser")
# domain = load_domain(joinpath(path, "domain.hpd"))
problem = load_problem(joinpath(path, "problem.hpd"))
1