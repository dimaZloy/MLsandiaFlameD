

debug = false;
geenerateDataSet = false;

nCells = 4608;
nTimeLevels = Int32( 3115008/4/nCells );
nSpecie = 5;

dataT = zeros(Float32,nTimeLevels*nCells);
dataTindex = zeros(Int32,nCells);

for i = 1:nCells
	dataTindex[i] = i;
end

dataY0 = zeros(Float32,nTimeLevels*nCells,nSpecie);

dataY01 = zeros(Float32,nTimeLevels*nCells);
dataY02 = zeros(Float32,nTimeLevels*nCells);
dataY03 = zeros(Float32,nTimeLevels*nCells);
dataY04 = zeros(Float32,nTimeLevels*nCells);
dataY05 = zeros(Float32,nTimeLevels*nCells);

dataYF1 = zeros(Float32,nTimeLevels*nCells);
dataYF2 = zeros(Float32,nTimeLevels*nCells);
dataYF3 = zeros(Float32,nTimeLevels*nCells);
dataYF4 = zeros(Float32,nTimeLevels*nCells);
dataYF5 = zeros(Float32,nTimeLevels*nCells);

print("Load data: ");

s1 = open("dataT.bin","r")
s2 = open("dataY0.bin","r")
s3 = open("dataYF.bin","r")



for i =1:nTimeLevels
##for i =1:1
	
	index = (i-1)*nCells;
	
	
	println("reading i float:\t", index);
	
	for j =1:nCells
		
		dataT[j+index] = read(s1,Float32); 
		
		
		dataY01[j+index] = read(s2,Float32); 
		dataY02[j+index] = read(s2,Float32); 
		dataY03[j+index] = read(s2,Float32); 
		dataY04[j+index] = read(s2,Float32); 
		dataY05[j+index] = read(s2,Float32); 

		dataYF1[j+index] = read(s3,Float32); 
		dataYF2[j+index] = read(s3,Float32); 
		dataYF3[j+index] = read(s3,Float32); 
		dataYF4[j+index] = read(s3,Float32); 
		dataYF5[j+index] = read(s3,Float32); 

		
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

checkBoundness(dataT,200.0,3000.0,"T");
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

	figure(1)
	clf()

	zzplot(nTimeLevels,nCells, dataTindex,dataT, "ro" );


	figure(2)
	clf();
	subplot(5,1,1)
	zzplot(nTimeLevels,nCells,dataTindex,dataY01,"ro");
	ylim(0,1);
	subplot(5,1,2)
	zzplot(nTimeLevels,nCells,dataTindex,dataY02,"ro");
	ylim(0,1);
	subplot(5,1,3)
	zzplot(nTimeLevels,nCells,dataTindex,dataY03,"ro");
	ylim(0,1);
	subplot(5,1,4)
	zzplot(nTimeLevels,nCells,dataTindex,dataY04,"ro");
	ylim(0,1);
	subplot(5,1,5)
	zzplot(nTimeLevels,nCells,dataTindex,dataY05,"ro");
	ylim(0,1);

	figure(3)
	clf();
	subplot(5,1,1)
	zzplot(nTimeLevels,nCells,dataTindex,dataYF1,"bo");
	ylim(0,1);
	subplot(5,1,2)
	zzplot(nTimeLevels,nCells,dataTindex,dataYF2,"bo");
	ylim(0,1);
	subplot(5,1,3)
	zzplot(nTimeLevels,nCells,dataTindex,dataYF3,"bo");
	ylim(0,1);
	subplot(5,1,4)
	zzplot(nTimeLevels,nCells,dataTindex,dataYF4,"bo");
	ylim(0,1);
	subplot(5,1,5)
	zzplot(nTimeLevels,nCells,dataTindex,dataYF5,"bo");
	ylim(0,1);

end ## end plot debug 


print("\nreshaping data ...\n");

X = zeros(Float32,6);
Y = zeros(Float32,5);

NN = nTimeLevels*nCells;

i =1;

X[1] = dataT[i];
X[2] = dataY01[i];
X[3] = dataY02[i];
X[4] = dataY03[i];
X[5] = dataY04[i];
X[6] = dataY05[i];

Y[1] = dataYF1[i];
Y[2] = dataYF2[i];
Y[3] = dataYF3[i];
Y[4] = dataYF4[i];
Y[5] = dataYF5[i];


ss = (X,Y);

counter =2;

@time for i=2:NN
	
    global ss;
	global X,Y;
	global counter;
	
		
	X[1] = dataT[i];
	X[2] = dataY01[i];
	X[3] = dataY02[i];
	X[4] = dataY03[i];
	X[5] = dataY04[i];
	X[6] = dataY05[i];

	Y[1] = dataYF1[i];
	Y[2] = dataYF2[i];
	Y[3] = dataYF3[i];
	Y[4] = dataYF4[i];
	Y[5] = dataYF5[i];

	
	ss = [ss (X,Y)];
	
	counter += 1;
	if (counter > nCells)
		print("=")
		counter = 0;
	end
	
end

print("=>\ndone\n");

using BSON: @save
@save "flamedonestep.bson" ss

