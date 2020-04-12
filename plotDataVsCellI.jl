
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