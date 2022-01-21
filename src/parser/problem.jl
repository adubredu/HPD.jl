"Parse PDDL problem description."
parse_problem(expr::Vector) =
    GenericProblem(parse_description(:problem, expr)...)
parse_problem(str::AbstractString) =
    parse_problem(parse_string(str))
top_level_parsers[:problem] = parse_problem

"Parse domain for planning problem."
parse_domain_name(expr::Vector) = expr[2]
head_field_parsers[:problem][:domain] = parse_domain_name

"Parse objects in planning problem."
function parse_objects(expr::Vector)
    @assert (expr[1].name == :objects) ":objects keyword is missing."
    objs, types = parse_typed_consts(expr[2:end])
    types = Dict{Const,Symbol}(o => t for (o, t) in zip(objs, types))
    return (objects=objs, objtypes=types)
end
parse_objects(::Nothing) =
    (objects=Const[], objtypes=Dict{Const,Symbol}())
head_field_parsers[:problem][:objects] = parse_objects

"Parse initial formula literals in planning problem."
function parse_init(expr::Vector)
    @assert (expr[1].name == :init) ":init keyword is missing."
    return [parse_formula(e) for e in expr[2:end]]
end
parse_init(::Nothing) = Term[]
head_field_parsers[:problem][:init] = parse_init

"Parse goal formula in planning problem."
function parse_goal(expr::Vector)
    @assert (expr[1].name == :goal) ":goal keyword is missing."
    return parse_formula(expr[2])
end
parse_goal(::Nothing) = Const(true)
head_field_parsers[:problem][:goal] = parse_goal

"Parse metric expression in planning problem."
function parse_metric(expr::Vector)
    @assert (expr[1].name == :metric) ":metric keyword is missing."
    @assert (expr[2] in (:minimize, :maximize)) "Unrecognized optimization."
    return Compound(expr[2], [parse_formula(expr[3])])
end
parse_metric(expr::Nothing) = nothing
head_field_parsers[:problem][:metric] = parse_metric

"Parse constraints formula in planning problem."
function parse_constraints(expr::Vector)
    @assert (expr[1].name == :constraints) ":constraints keyword is missing."
    return parse_formula(expr[2])
end
parse_constraints(::Nothing) = nothing
head_field_parsers[:problem][:constraints] = parse_constraints

"Parse initializations for continuous variables"
function parse_cont_inits(expr::Vector) 
    return parse_formula(expr[2])
end
parse_cont_inits(::Nothing) = nothing
head_field_parsers[:problem][:continuous_inits] = parse_cont_inits

"Parse goal values for continuous variables"
function parse_cont_goals(expr::Vector) 
    return parse_formula(expr[2])
end
parse_cont_goals(::Nothing) = nothing
head_field_parsers[:problem][:continuous_goals] = parse_cont_goals

"Parse external numerical constraints formula in planning problem."
function parse_ext_constraints(expr::Vector) 
    return parse_formula(expr[2])
end
parse_ext_constraints(::Nothing) = nothing
head_field_parsers[:problem][:external_constraints] = parse_ext_constraints

"Parse objective function of planning problem."
function parse_objective_function(expr::Vector) 
    return parse_formula(expr[2])
end
parse_objective_function(::Nothing) = nothing
head_field_parsers[:problem][:objective_function] = parse_objective_function