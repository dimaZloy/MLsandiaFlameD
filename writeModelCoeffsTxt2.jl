

using Flux
##using DelimitedFiles
using BSON: @load


@load "flamedonestepML01_5.58e-5.bson" m
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

##open("file.txt","a") do io
##   println(io,"a=",a)
##end

if (saveWeights)

open("ML01_delim_file.txt", "w") do io

	##println(io, "a matrix size of: ",ai,"x",aj);
	##println(io, "a matrix:",":") 
	for i=1:ai
		for j = 1:aj
			println(io,"a[",i-1,"][",j-1,"]=", a[i,j],";");
		end
	end
	println(io,"");
	##println(io, "b vector size of: ",bi);
	##println(io, "b vector:") 
	for i=1:bi
		println(io,"b[",i-1,"]=",b[i],";");
	end
	println(io,"");
	##println(io,"c matrix size of: ",ci,"x",cj);
	##println(io, "c matrix:") 
	for i=1:ci
		for j = 1:cj
			println(io, "c[",i-1,"][",j-1,"]=", c[i,j],";");
		end
	end
	println(io,"");	
	##println(io, "d vector size of: ",di);
	##println(io, "d vector:") 
	for i=1:di
		println(io,"d[",i-1,"]=",d[i],";");
	end
	
end

end
