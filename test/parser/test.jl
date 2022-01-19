using HPL 

path = joinpath(dirname(pathof(HPL)), "..", "test", "parser")
domain = load_domain(joinpath(path, "domain.pddl"))
problem = load_problem(joinpath(path, "problem.pddl"))