obterValor <- function(sample, type, day, api, platform, language, activity, filesize){
	if(sample == "latency"){
		switch(type,
			mean = mean(dataset$LATENCY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			max = max(dataset$LATENCY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			min = min(dataset$LATENCY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			sd = sd(dataset$LATENCY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize])
		)
	} else if (sample == "memory"){
		switch(type,
			mean = mean(dataset$MEMORY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			max = max(dataset$MEMORY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			min = min(dataset$MEMORY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			sd = sd(dataset$MEMORY[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize])
		)
	} else if (sample == "cputime"){
		switch(type,
			mean = mean(dataset$CPUTIME[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			max = max(dataset$CPUTIME[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			min = min(dataset$CPUTIME[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize]),
			sd = sd(dataset$CPUTIME[dataset$DAY==day & dataset$API==api & dataset$PLATFORM==platform & dataset$LANGUAGE==language & dataset$ACTIVITY==activity & dataset$FILESIZE==filesize])
		)
	}
}

imprimirLatencia <- function (day, api, platform, language, activity){
	y <- c(
		obterValor("latency", "mean", day, api, platform, language, activity, "155"),
		obterValor("latency", "mean", day, api, platform, language, activity, "310"),
		obterValor("latency", "mean", day, api, platform, language, activity, "620"),
		obterValor("latency", "mean", day, api, platform, language, activity, "1240"),
		obterValor("latency", "mean", day, api, platform, language, activity, "2480")
		)
	x <- c(155, 310, 620, 1240, 2480)
	plot (x, y, ylim=c(0, 30000), xlim=c(0, 3000), xlab="File Size (Kb)", ylab="Latency Sample Mean (ms)", main=paste(day, api, platform, language, activity))

	# Barras de erro com valor máximo e mínimo #
	yHigh <- c(
		obterValor("latency", "max", day, api, platform, language, activity, "155"),
		obterValor("latency", "max", day, api, platform, language, activity, "310"),
		obterValor("latency", "max", day, api, platform, language, activity, "620"),
		obterValor("latency", "max", day, api, platform, language, activity, "1240"),
		obterValor("latency", "max", day, api, platform, language, activity, "2480")
		)
	yLow <- c(
		obterValor("latency", "min", day, api, platform, language, activity, "155"),
		obterValor("latency", "min", day, api, platform, language, activity, "310"),
		obterValor("latency", "min", day, api, platform, language, activity, "620"),
		obterValor("latency", "min", day, api, platform, language, activity, "1240"),
		obterValor("latency", "min", day, api, platform, language, activity, "2480")
		)
	arrows(x, yHigh, x, yLow, col=1, angle=90, length=0.1, code=3)

	# Barras de erro com o desvio padrão #
	yHigh <- c(
		obterValor("latency", "sd", day, api, platform, language, activity, "155"),
		obterValor("latency", "sd", day, api, platform, language, activity, "310"),
		obterValor("latency", "sd", day, api, platform, language, activity, "620"),
		obterValor("latency", "sd", day, api, platform, language, activity, "1240"),
		obterValor("latency", "sd", day, api, platform, language, activity, "2480")
		)
	yLow <- c(
		obterValor("latency", "sd", day, api, platform, language, activity, "155"),
		obterValor("latency", "sd", day, api, platform, language, activity, "310"),
		obterValor("latency", "sd", day, api, platform, language, activity, "620"),
		obterValor("latency", "sd", day, api, platform, language, activity, "1240"),
		obterValor("latency", "sd", day, api, platform, language, activity, "2480")
		)
	arrows(x, y+yHigh, x, y-yLow, col=2, angle=90, length=0.1, code=3)
}

imprimirRAM <- function (day, api, platform, language, activity){
	y <- c(
		obterValor("memory", "mean", day, api, platform, language, activity, "155"),
		obterValor("memory", "mean", day, api, platform, language, activity, "310"),
		obterValor("memory", "mean", day, api, platform, language, activity, "620"),
		obterValor("memory", "mean", day, api, platform, language, activity, "1240"),
		obterValor("memory", "mean", day, api, platform, language, activity, "2480")
		)
	x <- c(155, 310, 620, 1240, 2480)
	plot (x, y, ylim=c(0, 200000), xlim=c(0, 3000), xlab="File Size (Kb)", ylab="Memory Sample Mean (Kb)", main=paste(day, api, platform, language, activity))

	# Barras de erro com valor máximo e mínimo #
	yHigh <- c(
		obterValor("memory", "max", day, api, platform, language, activity, "155"),
		obterValor("memory", "max", day, api, platform, language, activity, "310"),
		obterValor("memory", "max", day, api, platform, language, activity, "620"),
		obterValor("memory", "max", day, api, platform, language, activity, "1240"),
		obterValor("memory", "max", day, api, platform, language, activity, "2480")
		)
	yLow <- c(
		obterValor("memory", "min", day, api, platform, language, activity, "155"),
		obterValor("memory", "min", day, api, platform, language, activity, "310"),
		obterValor("memory", "min", day, api, platform, language, activity, "620"),
		obterValor("memory", "min", day, api, platform, language, activity, "1240"),
		obterValor("memory", "min", day, api, platform, language, activity, "2480")
		)
	arrows(x, yHigh, x, yLow, col=1, angle=90, length=0.1, code=3)

	# Barras de erro com o desvio padrão #
	yHigh <- c(
		obterValor("memory", "sd", day, api, platform, language, activity, "155"),
		obterValor("memory", "sd", day, api, platform, language, activity, "310"),
		obterValor("memory", "sd", day, api, platform, language, activity, "620"),
		obterValor("memory", "sd", day, api, platform, language, activity, "1240"),
		obterValor("memory", "sd", day, api, platform, language, activity, "2480")
		)
	yLow <- c(
		obterValor("memory", "sd", day, api, platform, language, activity, "155"),
		obterValor("memory", "sd", day, api, platform, language, activity, "310"),
		obterValor("memory", "sd", day, api, platform, language, activity, "620"),
		obterValor("memory", "sd", day, api, platform, language, activity, "1240"),
		obterValor("memory", "sd", day, api, platform, language, activity, "2480")
		)
	arrows(x, y+yHigh, x, y-yLow, col=2, angle=90, length=0.1, code=3)
}

imprimirCPU <- function (day, api, platform, language, activity){
	y <- c(
		obterValor("cputime", "mean", day, api, platform, language, activity, "155"),
		obterValor("cputime", "mean", day, api, platform, language, activity, "310"),
		obterValor("cputime", "mean", day, api, platform, language, activity, "620"),
		obterValor("cputime", "mean", day, api, platform, language, activity, "1240"),
		obterValor("cputime", "mean", day, api, platform, language, activity, "2480")
		)
	x <- c(155, 310, 620, 1240, 2480)
	plot (x, y, ylim=c(0, 6), xlim=c(0, 3000), xlab="File Size (Kb)", ylab="CPU Time Sample Mean (ms)", main=paste(day, api, platform, language, activity))

	# Barras de erro com valor máximo e mínimo #
	yHigh <- c(
		obterValor("cputime", "max", day, api, platform, language, activity, "155"),
		obterValor("cputime", "max", day, api, platform, language, activity, "310"),
		obterValor("cputime", "max", day, api, platform, language, activity, "620"),
		obterValor("cputime", "max", day, api, platform, language, activity, "1240"),
		obterValor("cputime", "max", day, api, platform, language, activity, "2480")
		)
	yLow <- c(
		obterValor("cputime", "min", day, api, platform, language, activity, "155"),
		obterValor("cputime", "min", day, api, platform, language, activity, "310"),
		obterValor("cputime", "min", day, api, platform, language, activity, "620"),
		obterValor("cputime", "min", day, api, platform, language, activity, "1240"),
		obterValor("cputime", "min", day, api, platform, language, activity, "2480")
		)
	arrows(x, yHigh, x, yLow, col=1, angle=90, length=0.1, code=3)

	# Barras de erro com o desvio padrão #
	yHigh <- c(
		obterValor("cputime", "sd", day, api, platform, language, activity, "155"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "310"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "620"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "1240"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "2480")
		)
	yLow <- c(
		obterValor("cputime", "sd", day, api, platform, language, activity, "155"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "310"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "620"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "1240"),
		obterValor("cputime", "sd", day, api, platform, language, activity, "2480")
		)
	arrows(x, y+yHigh, x, y-yLow, col=2, angle=90, length=0.1, code=3)
}

dataset <- read.csv2("queryFULL.csv", header=TRUE, sep=",", dec=".")

dates = c("2016-04-11", "2016-04-12", "2016-04-13", "2016-04-14", "2016-04-15")
apis = c("nativa", "multicloud")
platforms = c("aws")
languages = c("python")
activities = c("upload", "download")
for (date in dates){
	for (api in apis){
		for (platform in platforms){
			for (language in languages){
				for (activity in activities){
					#par (mfrow=c(2, 2))
					imprimirLatencia(date, api, platform, language, activity)
					imprimirRAM(date, api, platform, language, activity)
					imprimirCPU(date, api, platform, language, activity)
				}
			}
		}
	}
}