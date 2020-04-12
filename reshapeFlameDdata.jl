
print("\nreshaping data ...\n");

X = zeros(Float64,6);
Y = zeros(Float64,5);


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


XX = zeros(Float64,6,NN);
YY = zeros(Float64,5,NN);

ss = (X,Y);

XX[:,1] = X;
YY[:,1] = Y;


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
	
	XX[:,i] = X;
	YY[:,i] = Y;
	
	
	counter += 1;
	if (counter > nCells)
		print("=")
		counter = 0;
	end
	
end

print("=>\ndone\n");

using BSON: @save
@save "flamedonestepML01_SS.bson" ss
@save "flamedonestepML01_XX.bson" XX
@save "flamedonestepML01_YY.bson" YY
