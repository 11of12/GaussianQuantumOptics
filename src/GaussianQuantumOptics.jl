import QuantumOpticsBase: coherentstate
import QuantumInterface: AbstractOperator
import StaticArrays: SMatrix, SVector

abstract type BosonicState end
abstract type GaussianOperator <: AbstractOperator end


"""
    GaussianState(means::V, covariance::T)

Arbitrary Gaussian state characterized by mean value vector `mean` and covariance matrix `covariance`.
"""
struct GaussianState{V,T} <: BosonicState
    mean::V
    covariance::T
end


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


"""
    DisplaceOperator(alpha::N)

Displacement operator, a Gaussian unitary defined by the relation `D(α)|0⟩ = |α⟩`.
"""
struct DisplaceOperator{N} <: GaussianOperator
    alpha::N
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


"""
    The "*" will apply a symplectic matrix to a GaussianState struct via V' = S V transpose(S), where S is the symplectic matrix.
"""
function Base.:(*)(x::DisplaceOperator{AbstractVector}, y::GaussianState{V,T}) where {V,T}
    # insert code for applying multi-mode displacement operator to multi-mode Gaussian state
end


"""
    Combining modes is represented by the tensor product symbol. Mathematically, this is a direct sum
"""

function Base.:(⊗)(x::GaussianState{V,T}, y::GaussianState{V,T}) where {V,T}
    # insert code for applying multi-mode displacement operator to multi-mode Gaussian state
end

