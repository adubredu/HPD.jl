struct Signature{N}
    name::Symbol
    type::Symbol
    args::NTuple{N, Var}
    argtypes::NTuple{N, Symbol}
end


abstract type Action end
struct GenericAction <: Action
    name::Symbol # Name of action
    args::Vector{Var} # GenericAction parameters
    types::Vector{Symbol} # Parameter types
    precond::Term # Precondition of action
    effect::Term # Effect of action
    cont_precond::Term #Continuous precondition of action
end


abstract type Domain end
@kwdef mutable struct GenericDomain <: Domain
    name::Symbol # Name of domain
    requirements::Dict{Symbol,Bool} = Dict() # PDDL requirements used
    typetree::Dict{Symbol,Vector{Symbol}} = Dict() # Types and their subtypes
    datatypes::Dict{Symbol,Type} = Dict() # Non-object data types
    constants::Vector{Const} = [] # List of constants
    constypes::Dict{Const,Symbol} = Dict() # Types of constants
    predicates::Dict{Symbol,Signature} = Dict() # Dictionary of predicates
    functions::Dict{Symbol,Signature} = Dict() # Dictionary of function declarations
    funcdefs::Dict{Symbol,Any} = Dict() # Dictionary of function definitions
    axioms::Dict{Symbol,Clause} = Dict() # Axioms / derived predicates
    actions::Dict{Symbol,Action} = Dict() # Action definitions
    _extras::Dict{Symbol,Any} # Extra fields
end


abstract type Problem end
abstract type State end
@kwdef mutable struct GenericProblem <: Problem
    name::Symbol # Name of problem
    domain::Symbol # Name of associated domain
    objects::Vector{Const} # List of objects
    objtypes::Dict{Const,Symbol} # Types of objects
    init::Vector{Term} # Predicates that hold in initial state
    goal::Term # Goal formula
    metric::Union{Term,Nothing} # Metric formula
    constraints::Union{Term,Nothing} # Constraints formula
end


