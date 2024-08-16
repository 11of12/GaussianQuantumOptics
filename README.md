# GaussianQuantumOptics.jl

**Note: This description is a vision for the future, and does not describe current functionality**

GaussianQuantumOptics.jl is a toolbox whose functionality is similar to QuantumOptics.jl, but with a focus on Gaussian states and Gaussian operations. 

GaussianQuantumOptics.jl allows users to define an inital multimode gaussian states, evolve it through an optical circuit, then represent the final state using standard approaches. The process is as follows
1. For each mode, the user defines an initial state. Initial states include vacuum state, coherent state, squeezed coherent state, or thermal state. 
2. Modes are combined to generate an inital multimode gaussian state
3. Operators are applied to specific user defined modes of the multimode gaussian state. Operators include displacement, single-mode squeezing, two modes squeezing, and phase. 
4. A final gaussian state can be analyzed, for example using the Wigner Function representation of the state.  

The GaussianQuantumOptics.jl also has symbolic capabilities, with integration to QuantumSymbolics.jl, allowing a user to have variables in the final quantum state expression, which translate to symbolic forms of performance metrix following operations such as detection. 