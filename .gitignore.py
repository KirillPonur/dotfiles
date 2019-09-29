import os
useful_dirs=[
            '.config',
            '.local/share'
            ]
useful_sub_dirs=[
                 ['gtk-3.0','user-dirs.dirs','user-dirs.locale','sublime-text-3/Packages/User','sublime-text-3/Local/License.sublime_license'],
                 ['plasma']
                ]

gitignore=[]
ignored=[]

for i in range(len(useful_dirs)):
    for j in range(len(useful_sub_dirs[i])):
        ignored.append(useful_dirs[i]+'/'+useful_sub_dirs[i][j])

file = open('.gitignore','r')
with file as f:
    n=0
    lines=f.readlines()
    lines_after=[]
    for line in lines:
        if line!='\n' and line[0]!='#':
            gitignore.append(line[:-1])

# print(gitignore)
directories=[useful_dirs[i]+'/'+ x for i in range(len(useful_dirs)) for x in os.listdir('./'+useful_dirs[i])]

directories=directories+ ['.cache','.git',
                          '.gitkraken','.ipython',
                          '.kde4','.pki','.steam',
                          '.texlive', 
                          '.bash_history','.bash_logout','.bash_profile',
                          '.esd_auth','downloads','documents',
                          '.steampath','.steampid','.Xauthority','.Xclients',
                          '.xinitrc','.viminfo','.profile',
                          '.vim/plugged','.vim/sessions']
ignored = set(ignored)
directories = set(directories+gitignore)
result = sorted( list(   directories  - ignored   ) )
print(result)

lines=[]
with open('.gitignore','w') as f:
    for i in result:
        lines.append(i+'\n')
    for line in lines:
        f.write(line)
file.close()