
file_pointer = './magic-flavor.txt'


def sql_gen(line):
	table = 'Sentence'
	cols = '(words,sourceId)'
	return f'''INSERT INTO "{table}" {cols} VALUES ('{line}', 1);\n'''

def file_writer():
	with open(file_pointer,'r+') as f:
		lines = f.readlines()
		print('...ingesting {} words'.format(len(lines)))
		with open('./insert-magic-sentences.sql','w+') as w:
			for line in lines:
				w.write(sql_gen(line.strip('\n')))
			w.close()
		f.close()

file_writer()






