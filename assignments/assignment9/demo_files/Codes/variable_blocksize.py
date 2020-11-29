from matplotlib import pyplot as plt
import subprocess


basecommand = "../d4-7/dineroIV -l1-usize 8K -l1-ubsize "
restcommand = " -l1-uassoc 2 -l1-uwalloc a -l1-uwback a -l1-uccc  -informat d < ../d4-traces/"

blocksample = [1, 2, 4, 8, 16, 32, 64, 128, 256]

for filename in ["cc1.din","spice.din","tex.din"]:
	ans = []
	for block in blocksample:
 		bashCommand = basecommand + str(block*4) + restcommand + filename
		output = subprocess.check_output(['bash','-c', bashCommand])
		ans.append(float(output.split("\n")[35].split()[3]))

	plt.plot(blocksample, ans, linestyle='dashed', linewidth = 2, marker='o', markersize=4,label=filename) 

plt.xlabel('Block Size') 
plt.ylabel('Demand Miss Rate') 
plt.title('Impact of block size') 
plt.legend()

plt.show()