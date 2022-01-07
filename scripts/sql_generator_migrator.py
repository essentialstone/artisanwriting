
in_file = './magic-flavor.txt'
out_file = './insert-magic-sentences.sql'

def sql_gen(line):
	return f'''INSERT INTO "Sentence" ("words", "sourceId") VALUES ('{line}', 1);\n'''

def file_writer():
	with open(in_file,'r+') as f:
		lines = f.readlines()
		print('...ingesting {} words'.format(len(lines)))
		with open(out_file,'w+') as w:
			for line in lines:
				w.write(sql_gen(line.strip()))
			w.close()
		f.close()

file_writer()






