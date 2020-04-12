

##include("readBinaryFlameDoneStep.jl")


using Flux
using Statistics
using BSON: @load

using Flux: @epochs
using PyPlot; 


debugReadData = true;

if (debugReadData)

	print("\nreading dataset ...\n");
	@time @load "flamedonestepML01_SS.bson" ss
	@time @load "flamedonestepML01_XX.bson" XX
	@time @load "flamedonestepML01_YY.bson" YY
end


@load "flamedonestepML01_1e-4.bson" m


#m = Flux.Chain(Dense(6,7,σ),Dense(7,5), softmax)
##m = Flux.Chain(Dense(6,7,relu.(XX)),Dense(7,5), relu)


##loss(XX,YY) = Flux.crossentropy(m(XX),YY);

loss(X,Y) = Flux.mse(m(XX),YY);

error = loss(XX,YY);
print("Initial loss: ", error);

ps = Flux.params(m);

##evalcb = ()-> @show(loss(XX,YY))

accuracy =  1e-5;
learningRate = 0.005;

evalcb = function ()
	global error;
	global accuracy;
	lerr = loss(XX,YY);
	error = [error lerr]
	@show lerr;
	lerr < accuracy && Flux.stop();
end

opt = NADAM(learningRate, (0.89, 0.995))
##N = 100000;

@epochs 1 Flux.train!(loss, ps, ss, opt, cb = Flux.throttle(evalcb,1))

using BSON: @save
@save "flamedonestepML01.bson" m
@save "flamedonestepML01err.bson" error



