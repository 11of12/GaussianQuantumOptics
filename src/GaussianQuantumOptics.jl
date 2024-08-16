# Note: This is a work in progress and is not yet functional.


import QuantumOpticsBase: coherentstate
import QuantumInterface: AbstractOperator
import StaticArrays: SMatrix, SVector
using LinearAlgebra

abstract type BosonicState end
abstract type GaussianOperator end


"""
    GaussianState(means::V, covariance::T)

Arbitrary Gaussian state characterized by mean value vector `mean` and covariance matrix `covariance`.
"""
struct GaussianState{V,T} <: BosonicState
    mean::V
    covariance::T
end

## Initial States


"""
    vacuumstate([Tm = SVector{2}, Tc = SMatrix{2,2}])

Create a vacuum state, a Gaussian state with zero photons.
"""
function vacuumstate(::Type{Tm}, ::Type{Tc}) where {Tm, Tc}
    mean = Tm([0.0, 0.0])
    covar = Tc([1.0 0.0; 0.0 1.0])
    return GaussianState(mean, covar)
end
vacuumstate() = vacuumstate(SVector{2}, SMatrix{2,2})


"""
    

"""
function squeeze(::Type{Tm}, ::Type{Tc}) where {Tm, Tc}
    mean = Tm([0.0, 0.0])
    covar = Tc([1.0 0.0; 0.0 1.0])
    return GaussianState(mean, covar)
end
vacuumstate() = vacuumstate(SVector{2}, SMatrix{2,2})


"""
    coherentstate([Tm = SVector{2}, Tc = SMatrix{2,2},] alpha::N)

Create a coherent state, the single-photon quantum analogue of monochromatic classical electromagnetic field, where `alpha` is the eigenvalue of
the bosonic annihilation operator.
"""
function coherentstate(::Type{Tm}, ::Type{Tc}, alpha::A) where {Tm, Tc, A<:Number}
    q = real(alpha)
    p = imag(alpha)
    mean = Tm([q, p])
    covar = Tc([1.0 0.0; 0.0 1.0])
    return GaussianState(mean, covar)
end
coherentstate(alpha::A) where {A<:Number} = coherentstate(SVector{2}, SMatrix{2,2}, alpha)

function thermal

end

function tmsst

end

function displacesqueeze

end


## Operators

"""
    DisplaceOperator(alpha::N)

Displacement operator, a Gaussian unitary defined by the relation `D(α)|0⟩ = |α⟩`.
"""
struct DisplaceOperator{N} <: GaussianOperator
    alpha::N
end

struct singlemodesqueezingoperator

end

struct twomodesqueezingoperator

end

struct phaseoperator

end

struct beamsplitter

end


## Functional Operations


"""
The Operate function will allow the user to define a sequence of operators to apply to a Gaussian state for a specific mode set
"""

function operate([Operator1, Op2, Op3], State, [Mode1, Mode2, Mode3])

end


"""
    Combining modes is represented by the tensor product symbol. Mathematically, this is a direct sum
"""

function ⊗(x::GaussianState{V,T}, y::GaussianState{V,T}) where {V,T}
    # Concatenate the mean vectors of the two Gaussian states
    combined_mean = vcat(x.mean, y.mean)

    # Get the sizes of the covariance matrices
    size_x = size(x.covariance, 1)
    size_y = size(y.covariance, 1)

    # Create a matrix to hold the block-diagonal covariance matrix
    combined_size = size_x + size_y
    combined_covariance = zeros(eltype(x.covariance), combined_size, combined_size)

    # Insert the covariance matrices into the block diagonal
    combined_covariance[1:size_x, 1:size_x] = x.covariance
    combined_covariance[size_x+1:end, size_x+1:end] = y.covariance

    return GaussianState(combined_mean, combined_covariance)
end



"""
    The "*" will allow a user to apply a correctly formated operator to a Gaussian state. .
"""
function Base.:(*)(x::DisplaceOperator{AbstractVector}, y::GaussianState{V,T}) where {V,T}
    # insert code for applying multi-mode displacement operator to multi-mode Gaussian state
end

function Base.:(*)(x::DisplaceOperator{<:Number}, y::GaussianState{V,T}) where {V,T}
    mean = y.mean
    if length(mean) > 2
        throw(ArgumentError("You are applying a single-mode displacement operator to a multi-mode Gaussian state."))
    else
        covar = y.covariance
        q = y.mean[1]
        p = y.mean[2]
        return GaussianState(V([q+sqrt(2)*real(x.alpha),p+sqrt(2)*imag(x.alpha)]), covar)
    end
end


# Measurements and Representation


function Wigner(State)

end

function Homodyne(State, mode)

end

