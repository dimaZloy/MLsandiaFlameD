
	##figure(4)
	##clf()
	##zzplot(nTimeLevels,nCells, dataTindex,dataT, "ro" );

	ms = 0.1;

	figure(5)
	clf();
	subplot(5,1,1)
	plot(dataT,dataY01,"ro",markersize = ms);
	##ylim(0,1);
	subplot(5,1,2)
	plot(dataT,dataY02,"ro",markersize = ms);
	#zzplot(nTimeLevels,nCells,dataT,dataY02,"ro");
	##ylim(0,1);
	subplot(5,1,3)
	plot(dataT,dataY03,"ro",markersize = ms);
	#zzplot(nTimeLevels,nCells,dataT,dataY03,"ro");
	##ylim(0,1);
	subplot(5,1,4)
	plot(dataT,dataY04,"ro",markersize = ms);
	#zzplot(nTimeLevels,nCells,dataT,dataY04,"ro");
	##ylim(0,1);
	subplot(5,1,5)
	plot(dataT,dataY05,"ro",markersize = ms);

	#zzplot(nTimeLevels,nCells,dataT,dataY05,"ro");
	##ylim(0,1);

	figure(6)
	clf();
	subplot(5,1,1)
	plot(dataT,dataYF1,"bo",markersize = ms);

	#zzplot(nTimeLevels,nCells,dataT,dataYF1,"bo");
	##ylim(0,1);
	subplot(5,1,2)
	plot(dataT,dataYF2,"bo",markersize = ms);
	#zzplot(nTimeLevels,nCells,dataT,dataYF2,"bo");
	##ylim(0,1);
	subplot(5,1,3)
	plot(dataT,dataYF3,"bo",markersize = ms);
	#zzplot(nTimeLevels,nCells,dataT,dataYF3,"bo");
	#ylim(0,1);
	subplot(5,1,4)
	plot(dataT,dataYF4,"bo",markersize = ms);
	#zzplot(nTimeLevels,nCells,dataT,dataYF4,"bo");
	#ylim(0,1);
	subplot(5,1,5)
	plot(dataT,dataYF5,"bo",markersize = ms);
	#zzplot(nTimeLevels,nCells,dataT,dataYF5,"bo");
	#ylim(0,1);