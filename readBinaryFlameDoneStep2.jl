
## DL
## rev 8-April-2020
## second ML DataBase for RANS Sandia Flame D
## changed float to double


debug = true;
##generateDataSet = false;



nCells = 4608;

nTimeLevels = Int32( 12460032/8/nCells );
print("Total timeLevels: ",nTimeLevels);
nSpecie = 5;

NN = nTimeLevels*nCells;


dataT = zeros(Float64,NN);
dataTindex = zeros(Int32,nCells);

for i = 1:nCells
	dataTindex[i] = i;
end

## dataY0 = zeros(Float64,NN,nSpecie);

dataY01 = zeros(Float64,NN);
dataY02 = zeros(Float64,NN);
dataY03 = zeros(Float64,NN);
dataY04 = zeros(Float64,NN);
dataY05 = zeros(Float64,NN);

dataYF1 = zeros(Float64,NN);
dataYF2 = zeros(Float64,NN);
dataYF3 = zeros(Float64,NN);
dataYF4 = zeros(Float64,NN);
dataYF5 = zeros(Float64,NN);

print("Load data: ");

s1 = open("ML01_dataT.bin","r")
s2 = open("ML01_dataY0.bin","r")
s3 = open("ML01_dataYF.bin","r")



for i =1:nTimeLevels
##for i =1:1
	
	index = (i-1)*nCells;
	
	
	println("reading i double:\t", index);
	
	for j =1:nCells
		
		dataT[j+index] = read(s1,Float64); 
		
		
		dataY01[j+index] = read(s2,Float64); 
		dataY02[j+index] = read(s2,Float64); 
		dataY03[j+index] = read(s2,Float64); 
		dataY04[j+index] = read(s2,Float64); 
		dataY05[j+index] = read(s2,Float64); 

		dataYF1[j+index] = read(s3,Float64); 
		dataYF2[j+index] = read(s3,Float64); 
		dataYF3[j+index] = read(s3,Float64); 
		dataYF4[j+index] = read(s3,Float64); 
		dataYF5[j+index] = read(s3,Float64); 

		
		#dataYF[j+index,1] = read(s3,Float32); 
		#dataYF[j+index,2] = read(s3,Float32); 
		#dataYF[j+index,3] = read(s3,Float32); 
		#dataYF[j+index,4] = read(s3,Float32); 
		#dataYF[j+index,5] = read(s3,Float32); 
				
	end
	
end

close(s1)
close(s2)
close(s3)

print("done\n");

using PyPlot;

function normalizeT(dataX)

	xmin_ =  findmin(dataX) ;
	xmax_ =  findmax(dataX) ;
	
	print("\n Max X: ", xmax_);
	print("\n Min X: ", xmin_);
	
	
	xmin =Float64( xmin_[1]);
	xmax =Float64( xmax_[1]);
	dx = Float64(xmax-xmin);

	dataX[:] =  (dataX[:] .- xmin) ./ dx ; 
	
	#for i =1:NN
	#	dataX[i] = (dataX[i] - xmin) / dx; 
	#end
	
end

function  checkBoundness(dataX,xMinB,xMaxB,field)
	xmin = findmin(dataX);
	xmax = findmax(dataX);
	
	if ( xmin[1] < 0.0 || xmax[1] > xMaxB )
		print("\nWarning with boundness of ", field, "xmin=",xmin[1],"\txmax=",xmax[1]);
	end
	
end


function zzplot(nTimeLevels,nCells, dataTindex,dataX, marker )
	
	for i=1:nTimeLevels
		index = (i-1)*nCells;
		plot(dataTindex,dataX[1+index:nCells+index],marker);
	end
	
end



dataY01 = abs.(dataY01);
dataY02 = abs.(dataY02);
dataY03 = abs.(dataY03);
dataY04 = abs.(dataY04);
dataY05 = abs.(dataY05);

dataYF1 = abs.(dataYF1);
dataYF2 = abs.(dataYF2);
dataYF3 = abs.(dataYF3);
dataYF4 = abs.(dataYF4);
dataYF5 = abs.(dataYF5);


checkBoundness(dataT,200.0,3000.0,"T");

normalizeT(dataT); ## normalize T to 0-1


checkBoundness(dataY01,0.0,1.0,"Y01");
checkBoundness(dataY02,0.0,1.0,"Y02");
checkBoundness(dataY03,0.0,1.0,"Y03");
checkBoundness(dataY04,0.0,1.0,"Y04");
checkBoundness(dataY05,0.0,1.0,"Y05");

checkBoundness(dataYF1,0.0,1.0,"YF1");
checkBoundness(dataYF2,0.0,1.0,"YF2");
checkBoundness(dataYF3,0.0,1.0,"YF3");
checkBoundness(dataYF4,0.0,1.0,"YF4");
checkBoundness(dataYF5,0.0,1.0,"YF5");


if (debug)

	include("plotDataVsT");
	##include("plotDataVsCellI");
		

end ## end plot debug 




