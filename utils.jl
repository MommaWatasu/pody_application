###here is Pody layer
const tanh_a = (0, 1, 0, 1/3, 0, 2/15)
Aaf(n) = tanh_a[1 : n]

pody(x) = max(-1, min(1, evalpoly(x, (0, 1, 0, 1/3))))

struct PD{F, M<:AbstractMatrix, B}
    W::M
    b::B
    σ::F
    function PD(W, b)
        return new{typeof(pody), typeof(W), typeof(b)}(W, b, pody)
    end
end

function (layer::PD)(x::AbstractVecOrMat)
    W, b, σ = layer.W, layer.b, layer.σ
    σ.(W * x .+ b)
end

function Base.show(io::IO, a::PD)
    o, i = size(a.W)
    print("PD(IO:$i => $o, pody:[0, 1, 0, 1/3] * x)")
end

Flux.trainable(a::PD) = a.a, a.W
Flux.@functor PD
###end of Pody layer

###here is Data Keeper
struct DataKeeper
    data::Array{Tuple, 1}
    function DataKeeper()
        new(Array{Tuple}(undef, 0))
    end
end

function Base.push!(DK::DataKeeper, x::Tuple)
    if length(DK.data) == 100
        popfirst!(DK.data)
    end
    push!(DK.data, x)
end
###end of Data Keeper