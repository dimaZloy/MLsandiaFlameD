

##include("readBinaryFlameDoneStep.jl")


using Flux
using Statistics
using BSON: @load @save
using Flux: @epochs


debugReadData = false;

if (debugReadData)

	print("\nreading dataset ...\n");
	@time @load "flamedonestepSS.bson" ss
	@time @load "flamedonestepXX.bson" XX
	@time @load "flamedonestepYY.bson" YY
end


##nCells = 4608;
##nTimeLevels = Int32( 3115008/4/nCells );
##nSpecie = 5;
##NN = nCells*nTimeLevels;

##X = zeros(Float32,6,NN);
##Y = zeros(Float32,5,NN);

##print("\back retrive X-Y data ... ");

##@time for i = 1:NN
##	X[:,i] = ss[i][1];
##  Y[:,i] = ss[i][2];
#end

##baseline
##m = Flux.Chain(Dense(6,7,σ),Dense(7,5), softmax)

m = Flux.Chain(Dense(6,7,σ),Dense(7,5), softmax)
##m = Flux.Chain(Dense(6,7,relu.(XX)),Dense(7,5), relu)




##loss(XX,YY) = Flux.crossentropy(m(XX),YY);

loss(X,Y) = Flux.mse(m(XX),YY);

ps = Flux.params(m);

evalcb = ()-> @show(loss(XX,YY))
##evalcb2 = ()-> @show(loss2(X,Y))

@epochs 1 Flux.train!(loss, ps, ss, NADAM(), cb = Flux.throttle(evalcb,1))
##@epochs 1 Flux.train!(loss, ps3, ss, ADAM(), cb = Flux.throttle(evalcb,1))

##Flux.train!(loss2, ps, ab, ADAM(), cb="")

