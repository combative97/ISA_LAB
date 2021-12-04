#!bin/usr/evn python

if __name__=="__main__":
	fp=open("albero.txt",'w')
	ref=34
	ref2=33
	for i in range(36,64):
		if i<37:
			for k in range(16-int((i%ref)/2),-1,-1):
				fp.write("P"+str(k)+"("+str(i)+")<=partial"+str(k+int((i%ref)/2))+"("+str(i)+");\n")
			for l in range(16,15-int((i%ref)/2)+1,-1):
				fp.write("P"+str(l)+"("+str(i)+")<='0';\n")
		else:
			for k in range(16-int((i%ref2)/2),-1,-1):
				fp.write("P"+str(k)+"("+str(i)+")<=partial"+str(k+int((i%ref2)/2))+"("+str(i)+");\n")
			for l in range(16,15-int((i%ref2)/2)+1,-1):
				fp.write("P"+str(l)+"("+str(i)+")<='0';\n")
		fp.write("\n")
