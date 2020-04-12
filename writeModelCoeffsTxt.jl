

using Flux
using DelimitedFiles
using BSON: @load


##@load "flamedonestepM.bson" m
##@save "flamedonestepM.bson" m

ps = Flux.params(m);

a = collect(ps)[1];
b = collect(ps)[2];
c = collect(ps)[3];
d = collect(ps)[4];

ai, aj = size(a);
bi = length(b);
ci, cj = size(c);
di = length(d);


#	for i=1:ai
#		for j = 1:aj
#			print(a[i,j],"\t",i,"\t",j,"\n");
#		end
#	end

saveWeights = true;

if (saveWeights)

open("delim_file.txt", "w") do io

	as = string("a matrix size of: ",ai,"x",aj);
	writedlm(io, "a matrix:",":") 
	for i=1:ai
		for j = 1:aj
			writedlm(io, a[i,j]);
		end
	end
	
	bs = string("b vector size of: ",bi);
	##writedlm(io, bs)
	writedlm(io, "b vector:") 
	for i=1:bi
		writedlm(io, b[i]);
	end
	
	cs = string("c matrix size of: ",ci,"x",cj);
	##writedlm(io, cs)
	writedlm(io, "c matrix:") 
	for i=1:ci
		for j = 1:cj
			writedlm(io, c[i,j]);
		end
	end
	
	ds = string("d vector size of: ",di);
	##writedlm(io, ds)
	writedlm(io, "d vector:") 
	for i=1:di
		writedlm(io, d[i]);
	end
	
end

end