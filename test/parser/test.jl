using Revise
using HPD 

path = joinpath(dirname(pathof(HPD)), "..", "examples")#, "parser")
domain = load_domain(joinpath(path, "domain.hpd"))
problem = load_problem(joinpath(path, "problem.hpd"))
init = initstate(domain, problem)
goal = goalstate(domain, problem)
1