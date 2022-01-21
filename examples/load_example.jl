using Revise
using HPD 

path = joinpath(dirname(pathof(HPD)), "..", "examples")
domain = load_domain(joinpath(path, "domain.hpd"))
problem = load_problem(joinpath(path, "problem.hpd"))
state = initstate(domain, problem)
goal = goalstate(domain, problem)
1