from happytransformer import HappyTextClassification, TCTrainArgs
import pandas as pd
import pprint
import os, time


#decorate any function with this @timer and it will 
def timer(func):
	def wrapper():
		start_time=time.perf_counter()
		result=func()
		end_time=time.perf_counter()
		elapsed_time=end_time-start_time
		return result
	return wrapper


train_csv_str='./batch/v1_4_22_22/'

csv_list=os.listdir(train_csv_str)

tdf=pd.read_csv(os.path.join(train_csv_str,csv_list[0]),delimiter='\t', names=['text','label'])

happy_tc = HappyTextClassification(model_type="DISTILBERT",model_name="distilbert-base-uncased-finetuned-sst-2-english",num_labels=2)
args= TCTrainArgs(
	learning_rate=5e-5,
	num_train_epochs=10,
	batch_size=1,
	weight_decay=0,
	adam_beta1=0.9,
	adam_beta2=0.999,
	adam_epsilon=1e-8,
	max_grad_norm=1.0,
	save_preprocessed_data=False, #this can be changed - need to look into it
	save_preprocessed_data_path='./tc/output/',
	load_preprocessed_data=False,
	load_preprocessed_data_path="",
	fp16=False)
# happy_tc.train("./tc/tc_eval_1.csv", args=args)
file=os.path.join(train_csv_str,csv_list[0])
start_time=time.perf_counter()
print(f'Training on {file}..')
# with open(file) as f:
# 	print(f.readlines())

happy_tc.train(
	input_filepath=file,
	args=args)
end_time=time.perf_counter()
result=happy_tc.eval('./tc/tc_eval.csv')
print(f'Training took {end_time-start_time} seconds with {result.loss} loss.')


# I need to randomize a set of test data for each run and have it compile and read in to the file that is passed to "test"






