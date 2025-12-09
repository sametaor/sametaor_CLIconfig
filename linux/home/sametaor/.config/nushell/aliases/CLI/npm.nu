export alias npmg = npm i -g
export alias npmS = npm i -S
export alias npmD = npm i -D
export alias npmF = npm i -f

# The npmE alias modifies PATH; in Nushell, you’d generally use with-env:
export def npmE [cmd: string] {
  with-env [PATH ($env.PATH | prepend (npm bin))] { ^$cmd }
}

export alias npmO = npm outdated
export alias npmU = npm update
export alias npmV = npm -v
export alias npmL = npm list
export alias npmL0 = npm ls --depth=0
export alias npmst = npm start
export alias npmt = npm test
export alias npmR = npm run
export alias npmP = npm publish
export alias npmI = npm init
export alias npmi = npm info
export alias npmSe = npm search
export alias npmrd = npm run dev
export alias npmrb = npm run build
