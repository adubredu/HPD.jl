"Generic PDDL action definition."

GenericAction(term::Term, precond::Term, effect::Term) =
    GenericAction(term.name, get_args(term), Symbol[], precond, effect, 
        Compound(:cont_precond, Term[]), Compound(:cont_effect, Term[]), 
        Compound(:dynamics, Term[]))

Base.:(==)(a1::GenericAction, a2::GenericAction) = (a1.name == a2.name &&
    Set(a1.args) == Set(a2.args) && Set(a1.types) == Set(a2.types) &&
    a1.precond == a2.precond && a1.effect == a2.effect)

get_name(action::GenericAction) = action.name

get_argvars(action::GenericAction) = action.args

get_argtypes(action::GenericAction) = action.types

get_precond(action::GenericAction) = action.precond

function get_precond(action::GenericAction, args)
    subst = Subst(k => v for (k, v) in zip(action.args, args))
    return substitute(action.precond, subst)
end

get_effect(action::GenericAction) = action.effect

get_action(domain::GenericDomain, name::Symbol) = domain.actions[name]

function get_effect(action::GenericAction, args)
    subst = Subst(k => v for (k, v) in zip(action.args, args))
    return substitute(action.effect, subst)
end