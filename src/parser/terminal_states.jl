#init state
function initstate(domain::Domain, problem::GenericProblem)
    return initstate(domain, problem.objtypes, problem.init)
end

function initstate(domain::Domain, objtypes::AbstractDict)
    types = Set{Term}([Compound(ty, Term[o]) for (o, ty) in objtypes])
return GenericState(types, Set{Term}(), Dict{Symbol,Any}())
end

function initstate(domain::Domain, objtypes::AbstractDict,
    fluents::AbstractVector)
    state = initstate(interpreter, domain, objtypes)
    for t in fluents
        if t.name == :(==) # Non-Boolean fluents
            @assert length(t.args) == 2 "Assignments must have two arguments."
            term, val = t.args[1], t.args[2]
            @assert !isa(term, Var) "Initial terms cannot be unbound variables."
            state[term] = evaluate(domain, state, val)
        else # Boolean fluents
            push!(state.facts, t)
        end
    end
    return state
end

function initstate(domain::Domain, objtypes::AbstractDict,
    fluents::AbstractDict)
    state = initstate(domain, objtypes)
    for (name, val) in fluents
        set_fluent!(state, val, name)
    end
    return state
end

#goal state
function goalstate(domain::Domain, problem::GenericProblem)
    types = Set{Term}([Compound(ty, Term[o]) for (o, ty) in problem.objtypes])
    facts = Set{Term}(flatten_conjs(problem.goal))
    state = GenericState(types, facts, Dict{Symbol,Any}())
    return state
end

function goalstate(domain::Domain, objtypes::AbstractDict, terms)
    types = Set{Term}([Compound(ty, Term[o]) for (o, ty) in objtypes])
    goal = GenericState(types, Set{Term}(), Dict{Symbol,Any}())
    for t in flatten_conjs(terms)
        if t.name == :(==) # Function equality
            @assert length(t.args) == 2 "Assignments must have two arguments."
            term, val = t.args[1], t.args[2]
            @assert(is_func(term, domain) && !is_attached_func(term, domain),
                "Unrecognized function $(term.name).")
            @assert(is_ground(term), "Assigned terms must be ground.")
            @assert(isa(val, Const), "Terms must be equal to constants.")
            goal[term] = val.name
        elseif is_pred(t, domain) # Predicates
            push!(goal.facts, t)
        else
            error("Term $t in $terms cannot be handled.")
        end
    end
    return goal
end