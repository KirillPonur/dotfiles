import os
useful_dirs=['.config','.local/share']
useful_sub_dirs=[
                 ['gtk-3.0','systemd'],
				 ['plasma']
				]
for j in range(len(useful_dirs)):
	file = open('.gitignore','r')
	ignored=useful_sub_dirs[j]
	with file as f:
		n=0
		lines=f.readlines()
		lines_before=[]
		lines_after=[]
		for line in lines:
			if line == '#\\begin{'+useful_dirs[j]+'}\n':
				n_begin=n+1
			elif line == '#\\end{'+useful_dirs[j]+'}\n':
				n_end=n
			n+=1
		for i in range(len(lines)):
			if i<n_begin:
				lines_before.append(lines[i])
			if i>=n_end:
				lines_after.append(lines[i])
	file.close()

	directories=[x for x in os.listdir('./'+useful_dirs[j])]
	currently_inserted=[ lines[i] for i in range(n_begin,n_end)]
	lines_insert=[]

	result = list( set(directories) - set(currently_inserted) - set(ignored))
	result.sort()
	print(result)
	for i in result:
		lines_insert.append('\n'+useful_dirs[j]+'/'+i+'\n')

	with open('.gitignore','w') as f:
		lines=lines_before+lines_insert+lines_after
		for line in lines:
			f.write(line)
	file.close()


