

##include("readBinaryFlameDoneStep.jl")


using Flux
using Statistics
using BSON: @load @save
using Flux: @epochs


debugReadData = false;

if (debugReadData)

	print("\nreading dataset ...\n");
	@time @load "flamedonestep.bson" ss
	@time @load "flamedonestepX.bson" X
	@time @load "flamedonestepY.bson" Y
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



m = Flux.Chain(Dense(6,7,σ),Dense(7,5), softmax)
m2 = Flux.Chain(Dense(6,7,elu),Dense(7,5), elu)


loss(X,Y) = Flux.crossentropy(m(X),Y);
loss2(X,Y) = Flux.mse(m(X),Y);

ps = Flux.params(m);
ps2 = Flux.params(m2);

evalcb = ()-> @show(loss(X,Y))
evalcb2 = ()-> @show(loss2(X,Y))

##@epochs 1 Flux.train!(loss, ps, ss, ADAM(), cb = Flux.throttle(evalcb,30))
@epochs 1 Flux.train!(loss2, ps, ss, ADAM(), cb = Flux.throttle(evalcb2,10))

##Flux.train!(loss2, ps, ab, ADAM(), cb="")

